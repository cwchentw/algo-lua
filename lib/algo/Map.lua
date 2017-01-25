--- `algo.Map` class.
-- A thin OO wrapper around builtin associative array.
-- @classmod Map
local Map = {}
package.loaded['Map'] = Map

Map.__index = Map

--- Create an empty map.
-- @return An empty map.
function Map:new()
  self = {}
  setmetatable(self, Map)
  self.map = {}
  return self
end

--- Create a map with hash-style table.
-- @param t a hash-style table.
-- @return A map with (k, v) pairs in the table.
function Map:from_table(t)
  local map = Map:new()
  for k, v in pairs(t) do
    map:insert(k, v)
  end
  return map
end

--- Index the value by the key
-- @param k the key
-- @return The value
function Map:get(k)
  return self.map[k]
end

--- Insert (key, value) into the map.
-- @param k the key
-- @param v the value
function Map:insert(k, v)
  self.map[k] = v
end

--- Remove (key, value) from the map.
-- @param k the key
function Map:remove(k)
  self.map[k] = nil
end

--- Iterate over the map.
-- @return An iterator of (key, value) pairs.
function Map:iter()
  local p = nil
  local q = nil
  local k, v = next(self.map, nil)

  return function ()
    p = k
    q = v
    k, v = next(self.map, k)

    if p ~= nil then
      return p, q
    else
      return nil, nil
    end
  end
end

--- Reset the internal iterator.
-- Currently, it is just a dummy holder.
function Map:reset()
end

return Map
