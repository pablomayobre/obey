local next, concat = next, table.concat
local gsub, sub, match = string.gsub, string.sub, string.match

local split = function (str)
  local result = {}

  for i=1, #str do
    result[#result + 1] = sub(str, i, i)
  end

  return result
end

local parse = function (str)
  if not str then return end

  local value = {}
  local extra
  local first = sub(str, 1, 1)
  str = sub(str, 2)

  while true do
    local start, follow, finish = match(str, '([^\\'..first..']*)(.)(.*)')
    value[#value + 1] = start

    if follow == '\\' then
      value[#value + 1] = sub(finish, 1, 1)
      str = sub(finish, 2)
    else
      value = concat(value, '')
      extra = finish
      break
    end
  end

  return value, extra
end

local get_obey = function (arguments)
  local start = 1

  for k, _ in next, arguments do
    if k < start then start = k end
  end

  local obey = {}

  for i=start, 0 do
    local index = i - start + 1
    obey[index] = arguments[i]
  end

  return obey
end

local get_app = function (obey)
  local command = obey[#obey]

  return gsub(match(command or '', '[^/\\]+$'), '%.[^%.]+$', '')
end

local get_type = function (command)
  if command == '--help' or command == '-h' or command == nil then
    return 'help'
  elseif command == '--list' or command == '-l' then
    return 'list'
  elseif command == '--version' or command == '-v' then
    return 'version'
  else
    return 'run'
  end
end

local get_args = function (arguments)
  local args = {}

  for i=1, #arguments do
    args[i - 1] = arguments[i]
  end

  return args
end

local get_flags = function (args)
  local flags = {}

  for i=0, #args do
    local arg = args[i]

    if not arg then
      break
    end

    local flag = {}

    if sub(arg, 1, 2) == '--' then
      flag.type = 'Named Argument'
      flag.name = sub(match(arg, '--[^="\']+'), 3)

      local value = match(arg, '^--'..flag.name..'=?(.+)')

      flag.value, flag.extra = parse(value)
    elseif sub(arg, 1, 1) == '-' then
      flag.type = 'Short Flag'
      flag.complete_flag = sub(match(arg, '-[^="\']+'), 2)
      flag.order = split(flag.complete_flag)

      flag.flags = {}
      for j=1, #flag.order do
        local name = flag.order[j]
        flag.flags[name] = (flag.flags[name] or 0) + 1
      end

      local value = match(arg, '^-'..flag.complete_flag..'=?(.+)')

      flag.value, flag.extra = parse(value)
    else
      flag.type = 'Argument'
      flag.value = parse(arg)
    end

    flags[i] = flag
  end

  return flags
end

local cli = function (arguments)
  local parsed = {
    raw = arguments
  }

  parsed.obey = get_obey(arguments)

  parsed.app = get_app(parsed.obey)

  parsed.type = get_type(arguments[1])

  parsed.order = arguments[1]

  parsed.args = get_args(arguments)

  parsed.flags = get_flags(parsed.args)

  return parsed, arguments
end

return cli
