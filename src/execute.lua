local unpack = require "obey.compat".unpack -- luacheck: compat
local xpcall, traceback = xpcall, debug.traceback
local gsub, tostring = string.gsub, tostring

local execute = {}

local setfenv = require"obey.compat".setfenv
local getfenv = require"obey.compat".getfenv

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
