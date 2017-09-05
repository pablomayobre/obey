local loader = require 'obey.loader'

local strings = require 'obey.strings'
local usage, long_version = strings.usage, strings.long_version

local print, pairs, ipairs = print, pairs, ipairs

local types = {}

function types.help (parsed)
  print(usage(parsed.app))
  return 0
end

function types.version ()
  print(long_version)
  return 0
end

function types.list (parsed)
  local list, err = loader(false, parsed)

  if not list then
    print(err)
    return 1
  end

  local cmds = {}

  for k, _ in pairs(list) do
    cmds[#cmds + 1] = k
  end

  table.sort(cmds)

  print('Available commands:')
  for _, cmd in ipairs(cmds) do
    print('  $> '..parsed.app..' '..cmd)
  end

  return 0
end

function types.run (parsed)
  local list, err = loader(true, parsed)

  if not list then
    print(err)
    return 1
  end

  if list[parsed.order] then
    return list[parsed.order](parsed)
  else
    print('No such order found in "commands.lua"')
    return 1
  end
end

local function interface (parsed, args)
  return types[parsed.type](parsed, args)
end

return interface
