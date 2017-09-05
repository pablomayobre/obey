local arguments = require 'obey.arguments'
local interface = require 'obey.interface'

local main = function (args)
  return interface(arguments(args))
end

return main
