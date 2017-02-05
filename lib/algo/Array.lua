--- `algo.Array` class.
-- A dynamic array which uses builtin associative array internally.
-- @classmod Array
local Array = {}
package.loaded['Array'] = Array

Array.__index = function (t, k)
  if type(k) == "number" then
    return t:get(k)
  else
    return rawget(Array, k)
  end
end

Array.__newindex = function (t, k, v)
  if type(k) == "number" then
    t:set(k, v)
  else
    rawset(Array, k, v)
  end
end

Array.__len = function (o)
  return o:len()
end

Array.__eq = function (a1, a2)
  if a1:len() ~= a2:len() then
    return false
  end

  for i = 1, a1:len() do
    if a1[i] ~= a2[i] then
      return false
    end
  end

  return true
end

Array.__tostring = function (o)
  s = "("
  for i = 1, o:len() do
    s = s .. o.array[i]

    if i < o:len() then
      s = s .. ", "
    end
  end
  s = s .. ")"
  return s
end

--- Create an array with specific size.
-- @param size the size of the array
-- @return an array with specfic size and initial value `0`
function Array:new(size)
  self = {}
  self.array = {}
  self._size = size
  self._index = 0
  setmetatable(self, Array)
  for i = 1, size do
    table.insert(self.array, 0)
  end
  return self
end

--- Create an array from an array-style table.
-- @param table an array-style table
-- @return an array with the same size and value of the table
function Array:from_table(table)
  local array = Array:new(#table)
  local n = 0
  for i = 1, #table do
    array.array[i] = table[i]
    n = n + 1
  end
  array._size = n
  return array
end

function Array:get(i)
  return rawget(self.array, i)
end

function Array:set(i, e)
  self.array[i] = e
end

--- Peek the head of the array.
-- @return the element in the head, or nil if the array is empty
function Array:peek_head()
  return (self.array)[1]
end

--- Peek the tail of the array.
-- @return the element in the tail, or nil if the array is empty
function Array:peek_tail()
  return self.array[#(self.array)]
end

--- Iterate over the array.
-- @return An iterator over the array
function Array:next()
  return function ()
    self._index = self._index + 1

    return self:get(self._index)
  end
end

--- Iterate over the array.
-- @return An iterator over the array.
function Array:iter()
  return self:next()
end

function Array:reset()
  self._index = 0
end

--- Push an element into the tail of the array
-- @param e an element
function Array:push(e)
  table.insert(self.array, e)
  self._size = self._size + 1
end

--- Pop an element from the tail of the array.
-- @return an element, or nil if the array is empty
function Array:pop()
  if self:len() == 0 then
    return nil
  end

  local element = self.array[#(self.array)]
  table.remove(self.array, #(self.array))
  self._size = self._size - 1
  return element
end

--- Unshift an element into the head of the array.
-- @param e the element
function Array:unshift(e)
  self:insert(1, e)
end

--- Shift an element from the head of the array.
-- @return an element, or nil if the array is empty
function Array:shift()
  if self:len() == 0 then
    return nil
  end

  local element = self.array[1]
  table.remove(self.array, 1)
  self._size = self._size - 1
  return element
end

--- Insert an element into the array by the index.
-- @param index the index, starting from 1
-- @param element an element
function Array:insert(index, element)
  if index < 1 or index > #(self.array) + 1 then
    error("Index out of range")
  end

  table.insert(self.array, index, element)
  self._size = self._size + 1
end

--- Delete an element from the array by the index.
-- @param index the index, starting from 1
-- @return the deleted element
function Array:delete(index)
  if index < 1 or index > #(self.array) then
    error("Index out of range")
  end

  local element = self.array[index]
  table.remove(self.array, index)
  self._size = self._size - 1
  return element
end

function Array:len()
  return self._size
end

return Array
