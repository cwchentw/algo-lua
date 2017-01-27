--- `algo.LuaString` class.
-- An string object which thinnly wraps native Lua string, using an array to
-- store characters internally.
-- @classmod LuaString
local Array = require "algo.Array"
local LuaString = {}
package.loaded['LuaString'] = LuaString

LuaString.__index = LuaString

--- LuaString presentation of the string object.
LuaString.__tostring = function (o)
  return o.raw_string
end

--- Get the length of the string object.  Use OOP method call `len` is preferred.
LuaString.__len = function (o)
  return o:len()
end

--- Check whether two string object are equal.
LuaString.__eq = function (a, b)
  if a:len() ~= b:len() then
    return false
  end

  for i = 1, a:len() do
    if a:get(i) ~= b:get(i) then
      return false
    end
  end

  return true
end

--- Concatnate two string objects.
-- @return A new string object.
LuaString.__concat = function (a, b)
  return LuaString:new(a:raw() .. b:raw())
end

--- Create a string object.
-- @param s a string or number
-- @return A string object.
function LuaString:new(s)
  if type(s) ~= "number" and type(s) ~= "string" then
    error("Unsupported type: " .. type(s) .. " " .. string.format("%s", s) .. "\n")
  end

  local len = string.len(s)
  self = {}
  self.string = Array:new(len)
  self.raw_string = s
  self._index = 0
  setmetatable(self, LuaString)

  for i = 1, len do
    self.string:set(i, string.sub(s, i, i))
  end

  return self
end

--- Get raw string from LuaString object.
function LuaString:raw()
  return self.raw_string
end

--- Iterate over the string object.
-- @return An iterator of string objects; each object presents an LuaString.
function LuaString:iter()
  return function ()
    self._index = self._index + 1
    local s = self.string:get(self._index)
    if s then
      return LuaString:new(s)
    else
      return nil
    end
  end
end

--- Reset the internal iterator.
function LuaString:reset()
  self._index = 0
end

--- Get the character at the index number.
-- @param i The index number.
-- @return The character at the index number.
function LuaString:get(i)
  return self.string:get(i)
end

--- Get the length of the string object, using UTF8 character as the unit.
-- @return The lenght of the string.
function LuaString:len()
  return self.string:len()
end

--- Insert a substring at the index number.
-- @param idx the index, optional.
-- @param s a substring
-- @return A new string object.
function LuaString:insert(idx, s)
  local _idx = nil
  local _s = nil

  -- Check the type of parameters
  if type(idx) == "number" then
    _idx = idx
    _s = s
  elseif type(idx) == "string" then
    _s = idx
  else
    error("Invalid parameter type " .. type(idx) .. " " .. idx)
  end

  local raw = self.raw_string
  local len = string.len(raw)

  if _idx then
    raw = string.sub(raw, 1, _idx - 1) .. s .. string.sub(raw, _idx, len)
  else
    raw = raw .. _s
  end

  return LuaString:new(raw)
end

function LuaString:gsub(pattern, replace, n)
  local raw = string.gsub(self.raw_string, pattern, replace, n)
  return LuaString:new(raw)
end

--- Remove substring from LuaString.  If neither `start` nor `stop` is supplied,
-- remove last character.
-- @param start start location
-- @param stop stop location
-- @return A new LuaString
function LuaString:remove(start, stop)
  local raw = self.raw_string
  local len = string.len(raw)
  local _start = nil
  local _stop = nil
  if start == nil then
    _start = len
  else
    _start = start
  end

  if stop == nil then
    _stop = len
  else
    _stop = stop
  end

  raw = string.sub(raw, 1, _start - 1) .. string.sub(raw, _stop + 1, len)

  return LuaString:new(raw)
end

--- Reverse string.
-- @return Reversed LuaString
function LuaString:reverse()
  local raw = string.reverse(self.raw_string)
  return LuaString:new(raw)
end

--- Split string by a delimiter
-- @param d a delimiter, a native
-- @return An iterator of split LuaString.
function LuaString:split(d)
  local _d = nil

  if type(d) == "table" then
    _d = d.raw_string
  else
    _d = d
  end

  local str = self.raw_string
  local m = nil
  local last = false
  return function()
    if last then
      return nil
    end

    local i, j = string.find(str, _d)
    local out = nil

    if i then
      out = string.sub(str, 1, i - 1)
      str = string.sub(str, j + 1, str:len())
    end

    if out then
      return LuaString:new(out)
    else
      last = true
    end

    if last then
      return LuaString:new(str)
    end
  end
end

return LuaString
