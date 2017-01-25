--- `algo.String` class.
-- An UTF8-aware string object which thinnly wraps [lua-utf8](https://github.com/starwing/luautf8)
-- library, using an array to store UTF8 characters internally.
-- @classmod String
local utf8 = require "lua-utf8"
local Array = require "algo.Array"
local String = {}
package.loaded['String'] = String

--- Index string object.
-- Since using internal indexing is sometimes tricky; use OOP method call
-- `get` is preferred.
String.__index = function (t, k)
  if type(k) == "number" then
    return t.string:get(k)
  else
    return rawget(String, k)
  end
end

--- Assign data by indexing the string object.
-- Since using internal indexing is sometimes tricky; use OOP method call
-- `set` is preferred.
String.__newindex = function (t, k, v)
  if type(k) == "number" then
    t.string:set(k, v)
  else
    rawset(String, k, v)
  end
end

--- String presentation of the string object.
String.__tostring = function (o)
  return o.raw_string
end

--- Get the length of the string object.  Use OOP method call `len` is preferred.
String.__len = function (o)
  return o:len()
end

--- Check whether two string object are equal.
String.__eq = function (a, b)
  if type(a) ~= type(b) then
    return false
  end

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
String.__concat = function (a, b)
  return String:new(a:raw() .. b:raw())
end

--- Create a string object.
-- @param s a string or number
-- @return A string object.
function String:new(s)
  if type(s) ~= "number" and type(s) ~= "string" then
    error("Unsupported type: " .. type(s) .. " " .. string.format("%s", s) .. "\n")
  end

  local len = utf8.len(s)
  self = {}
  self.string = Array:new(len)
  self.raw_string = s
  self._index = 0
  setmetatable(self, String)

  for i = 1, len do
    self.string:set(i, utf8.sub(s, i, i))
  end

  return self
end

--- Get a raw Lua string from a string object.
function String:raw()
  return self.raw_string
end

--- Iterate over the string object.
-- @return An iterator of string objects; each object presents an UTF8 string.
function String:iter()
  return function ()
    self._index = self._index + 1
    local s = self.string:get(self._index)
    if s then
      return String:new(s)
    else
      return nil
    end
  end
end

--- Reset the internal iterator.
function String:reset()
  self._index = 0
end

--- Get the UTF8 character at the index number.
-- @param i The index number.
-- @return The UTF8 character at the index number.
function String:get(i)
  return self.string:get(i)
end

--- Get the length of the string object, using UTF8 character as the unit.
-- @return The lenght of the string.
function String:len()
  return self.string:len()
end

--- Insert a substring at the index number.
-- @param idx the index, optional.
-- @param s a substring
-- @return A new string object.
function String:insert(idx, s)
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

  if _idx then
    raw = utf8.insert(raw, _idx, _s)
  else
    raw = utf8.insert(raw, _s)
  end

  return String:new(raw)
end

function String:remove(start, stop)
  raw = utf8.remove(self.raw_string, start, stop)

  return String:new(raw)
end

function String:reverse()
  local raw = utf8.reverse(self.raw_string)
  return String:new(raw)
end

return String
