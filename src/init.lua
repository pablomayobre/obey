local obey = {}

local unpack = unpack or table.unpack -- luacheck: compat

obey.execute = require 'obey.execute'
obey.plugins = require 'obey.plugins'

local str = require 'obey.strings'

obey.__VERSION = str.long_version
obey.__SHORT_VERSION = str.version
obey.__DESCRIPTION = str.description
obey.__SEMVER = {unpack(str.semver)}
obey.__LICENSE = str.copyright..'\n\n'..str.license
obey.__URL = str.repository

return obey
