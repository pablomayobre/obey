local msg = 'The requested plugin is not installed in the system,'..
            'use LuaRocks to install an Obey compatible package'

local loaded = {}

local Plugins = {
  loaded = loaded
}

Plugins.load = function (name)
  if type(name) ~= 'string' then
    error('bad argument #1 to obey.plugin (string expected, got '..type(name)..')', 2)
  elseif #name == 0 then
    error('bad argument #1 to obey.plugin (you must specify a plugin name)', 2)
  end

  if loaded[name] then
    return true, loaded[name]
  end

  local ok, result = pcall(require, name .. '.obey')

  if ok then
    loaded[name] = result
    return true, result
  else
    return false, msg
  end
end

return Plugins
