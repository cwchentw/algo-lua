--- `algo.Heap` class.
-- Min/Max heap implemented with an array as a compact binary tree.
-- @classmod Heap
local Array = require "algo.Array"

local Heap = {}
package.loaded['Heap'] = Heap

Heap.__index = Heap

Heap.__tostring = function (o)
  local s = "("
  local len = o.array:len()

  for i = 1, len do
    s = s .. o.array:get(i)

    if i < len then
      s = s .. ", "
    end
  end

  s = s .. ")"

  return s
end

--- Create an empty heap.
-- @param func Optional, function (a, b) -> bool.  If not supplied, default
-- to `function (a, b) return a < b end`, impling a minimal heap.  If supplied
-- with `function (a, b) return a > b end`, it implies a maximal heap.
-- @return An empty heap
function Heap:new(func)
  if func == nil then
    func = function (a, b) return a < b end
  end

  self = {}
  setmetatable(self, Heap)
  self.array = Array:new(0)
  self._func = func
  self._index = 0

  return self
end

--- Create a heap with an array-style table.
-- @param func Optional, function (a, b) -> bool. See `new` method for the detail.
-- @param table an array-style table
-- @return A heap with elements in the table.
function Heap:from_table(func, table)
  local _func
  local _table

  if type(func) == "table" then  -- func is a table
    _func = function (a, b) return a < b end
    _table = func
  else
    _func = func
    _table = table
  end

  local heap = Heap:new(_func)
  for _, v in pairs(_table) do
    heap:push(v)
  end
  return heap
end

--- Push element into the heap.
-- @param e the element
function Heap:push(e)
  local half = function (i)
    return math.floor((i + 1) / 2)
  end

  self.array:push(e)

  local i = self.array:len()
  while i > 1 and half(i) > 0 do
    if not self._func(self.array:get(half(i)), self.array:get(i)) then
      -- Swap values
      local temp = self.array:get(i)
      self.array:set(i, self.array:get(half(i)))
      self.array:set(half(i), temp)
    end

    i = i - 1
  end
end

--- Pop the priority element from the heap.
-- @return the priority element.  If the heap is empty, return `nil`
function Heap:pop()
  local data = self.array:shift()

  local i = 1
  local len = self.array:len()
  while i <= len do
    local j = i * 2

    if j + 1 <= len and self.array:get(j) < self.array:get(j + 1) then
      j = j + 1
    end

    if j <= len and (not self._func(self.array:get(i), self.array:get(j))) then
      -- Swap values
      local temp = self.array:get(i)
      self.array:set(i, self.array:get(j))
      self.array:set(j, temp)
    end

    i = i + 1
  end

  return data
end

--- Peek the priority element of the heap.
-- @return the priority element.  If the heap is empty, return `nil`.
function Heap:peek()
  return self.array:get(1)
end

return Heap
