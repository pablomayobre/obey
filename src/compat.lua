
local unpack = unpack or table.unpack -- luacheck: compat

local debug = debug
if not debug and (not setfenv or not getfenv) then
	debug = require "debug" -- lua 5.3 does not load debug module by default
end

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

local compat = {}
compat.unpack = unpack
compat.setfenv = setfenv
compat.getfenv = getfenv

return compat
