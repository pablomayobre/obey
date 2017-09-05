local unpack = unpack or table.unpack -- luacheck: compat
local xpcall, traceback = xpcall, debug.traceback
local gsub, tostring = string.gsub, tostring

local execute = {}

-- luacheck: push compat
-- All rights of setfenv and getfenv go to Leafo
-- http://leafo.net/guides/setfenv-in-lua52-and-above.html
local setfenv = setfenv or function (fn, env)
  local i = 1

  while true do
    local name = debug.getupvalue(fn, i)
    if name == "_ENV" then
      debug.upvaluejoin(fn, i, (function()
        return env
      end), 1)
      break
    elseif not name then
      break
    end

    i = i + 1
  end

  return fn
end

local getfenv = getfenv or function (fn)
  local i = 1
  while true do
    local name, val = debug.getupvalue(fn, i)
    if name == "_ENV" then
      return val
    elseif not name then
      break
    end
    i = i + 1
  end
end
-- luacheck: pop

execute.setfenv = setfenv
execute.getfenv = getfenv

local function error_handler (msg)
  return traceback("Error: " .. gsub(tostring(msg), 2, "\n[^\n]+$", ""))
end

local function protect (func)
  return function (...)
    local args = {...}

    local f = function ()
      return func(unpack(args))
    end

    return xpcall(f, error_handler)
  end
end

execute.protect = protect

function execute.call(env, fn, ...)
  fn = setfenv(fn, env)

  fn = protect(fn)

  return fn(...)
end

return execute
