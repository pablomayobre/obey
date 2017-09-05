# OBEY
![GitHub release](https://img.shields.io/github/release/Positive07/obey.svg) [![license](https://img.shields.io/github/license/Positive07/obey.svg)][License]

OBEY is a tool that helps you automate tasks in your project by providing a simple way to execute Lua functions from your terminal.

## Docs

All the documentation can be found in the [Wiki][Wiki]

This README is just a short version with minimal explanation.

## Install

Install OBEY using [LuaRocks][LuaRocks]!

```bash
luarocks install obey
```

> For other ways to install OBEY check the [Install][Install] section in the [Wiki][Wiki]

## Usage

Create a `commands.lua` file in your directory.

The file must return a table with functions.

```lua
local commands = {}

commands.example = function ()
  print "example"
end

return commands
```

Then you can run the functions with OBEY through the command line

```bash
obey example

> example
```

> For more usage information check the [Usage][Usage] section in the [Wiki][Wiki]

## License

OBEY is licensed under the terms of the [MIT License][License]

Copyright (c) 2017 - [Pablo A. Mayobre (Positive07)][Positive]

[Wiki]: https://github.com/Positive07/obey/wiki
[LuaRocks]:https://luarocks.org/modules/positive07/obey
[Install]:https://github.com/Positive07/obey/wiki/Install
[Usage]:https://github.com/Positive07/obey/wiki/Usage
[License]:https://github.com/Positive07/obey/blob/master/LICENSE
[Positive]: https://github.com/Positive07
