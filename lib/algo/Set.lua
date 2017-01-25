--- `algo.Set` class.
-- A set which uses builtin associative array internally.
-- @classmod Set
local Set = {}
Set.__index = Set
package.loaded['algo.Set'] = Set

Set.__index = Set

--[[
Set.__index = function(t, k)
  if type(k) == "number" then
    local k_1 = string.format("%s", k)
    return rawget(t, k_1)
  else
    return rawget(Set, k)
  end
end

Set.__newindex = function(t, k, v)
  if type(k) == "number" then
    local k_1 = string.format("%s", k)
    rawset(t, k_1, v)
  else
    rawset(t, k, v)
  end
end
]]--

--- Create an empty set.
-- @return An empty set
function Set:new()
  self = {}
  setmetatable(self, Set)
  return self
end

--- Create a set from an array-style table.
-- @param table an array-style table
-- @return A set with the elements in the table
function Set:from_table(table)
  local set = Set:new()
  for _, v in pairs(table) do
    set[v] = true
  end
  return set
end

--- Check whether the element is in the set.
-- @param e the element to check
-- @return true when the element is in the set; otherwise, false
function Set:contain(e)
  return self[e] == true
end

--- Insert an element into the set.
-- @param e an element
function Set:insert(e)
  self[e] = true
end

--- Remove an element from the set.
-- @param e An element to remove
function Set:remove(e)
  self[e] = nil
end

--- Get the length of the set
-- @return the length of the set
function Set:len()
  local n = 0
  for _, _ in pairs(self) do
    n = n + 1
  end
  return n
end

--- Iterate over the set.
-- @return An iterator over the set
function Set:iter()
  local m = nil
  local k, _ = next(self, nil)

  return function ()
    m = k
    k, _ = next(self, m)
    if m ~= nil then
      return m
    else
      return nil
    end
  end
end

--- Reset the internal iterator.
-- Currently, it is just a dummy holder.
function Set:reset()
end

return Set
