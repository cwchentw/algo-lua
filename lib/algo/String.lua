--- `algo.String` class.
-- A factory class that generates specific string object under user's request.
-- Currently, `algo.UTF8String` and `algo.LuaString` are implemented.
-- @classmod String
local UTF8String = require "algo.UTF8String"
local LuaString = require "algo.LuaString"

local String = {}
package.loaded['String'] = String

String.__index = String

local function _check_encoding(e)
  assert(e == "native" or e == "utf8" or e == nil)
end

--- Create a string object.
-- @param s a Lua string
-- @param options Optional. A hash-style table presents options, including:
--
-- * encoding: native, utf8, or nil.  Default to native, i.e. LuaString.
--
-- @return A string object.
function String:new(s, options)
  local encoding = nil

  if type(options) == "table" then
    encoding = options["encoding"]
  end
  _check_encoding(encoding)

  if encoding == nil then
    encoding = "native"
  end

  if encoding == "utf8" then
    return UTF8String:new(s)
  elseif encoding == "native" then
    return LuaString:new(s)
  else
    return nil
  end
end

return String
