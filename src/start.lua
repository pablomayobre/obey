local main = require "obey.main"
local args = rawget(_G, 'arg') or {}

return os.exit(main(args))
