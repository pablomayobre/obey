local strings = {}

strings.description = 'A simple and configurable task automation tool.'

strings.semver = {0,1,0}
strings.version = 'v'..table.concat(strings.semver, '.')
strings.long_version = 'OBEY - '..strings.version

strings.copyright = 'COPYRIGHT (c) 2017 Pablo A. Mayobre (Positive07)'
strings.repository = 'https://github.com/Positive07/obey'
strings.documentation = 'https://positive07.github.com/obey'

strings.license = [[MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.]]

strings.usage = function (app)
  return strings.long_version..[[

]]..strings.description..[[


Usage:
]]..app..[[ (-h | --help)
> Display this usage message

]]..app..[[ (-v | --version)
> Prints the currently installed version of OBEY

]]..app..[[ (-l | --list)
> Shows a list of available commands in the current directory.

]]..app..[[ [command] [arguments]
> If the current directory has a command.lua and the file returns a table with
  commands, you can use OBEY to run any such command.

Example 'command.lua':
return {
  example = function ()
    print('Hello World!')
  end
}

--]]..app..[[ example
--Prints: Hello World!

Links:
OBEY on Github: ]]..strings.repository..[[

Documentation: ]]..strings.documentation
end

return strings
