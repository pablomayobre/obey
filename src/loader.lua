local protected_call = (require 'obey.execute').call

local noop = function () end

local function isFunction (value)
  if type(value) == 'function' then
    return true
  elseif type(value) == 'table' then
    local mt = getmetatable(value)
    if type(mt) == 'table' and isFunction(mt.__call) then
      return true
    end
  end
end

local require, next, type = require, next, type

local function wrap_command (env, fn)
  return function (...)
    local ok, result = protected_call(env, fn, ...)

    if ok then
      return isFunction(result) and result() or result
    else -- Error
      print(result)
      return 1
    end
  end
end

local loader = function (output, parsed)
  local dirsep = package.config:sub(1, 1)

  local path = ('.%s?.lua;.%s?%sinit.lua;'):format(dirsep, dirsep, dirsep)
  package.path = (path .. package.path):gsub(';;', ';')

  local file = '.'..dirsep..'commands.lua'

  if not os.rename(file, file) then -- Check if file exists
    return nil, 'Couldn\'t find commands.lua file in the current directory'
  end

  -- In the future we could sandbox the environment
  local env = _G or _ENV -- luacheck: compat

  env.obey = require 'obey'
  env.obey.parsed = parsed

  local load = function ()
    return require 'commands'
  end

  if not output then
    env.print = noop
    env.io.write = noop
  end

  local ok, orders = protected_call(env, load)

  local typ = type(orders)

  if not ok then
    return nil, orders
  elseif typ ~= 'table' then
    return nil, 'Expected commands.lua to return a table, but got a/an '..typ..' instead'
  else
    local protected_orders = {}

    for k, v in next, orders, nil do
      if type(k) == 'string' and type(v) == 'function' then
        protected_orders[k] = wrap_command(env, v)
      end
    end

    return protected_orders
  end
end

return loader
