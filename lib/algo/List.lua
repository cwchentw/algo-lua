--- `algo.List` class.
-- A doubly-linked list.  Use internal nodes to mimic traditional
-- linked lists in other languages like C/C++/Java.
-- @classmod List
local List = {}
package.loaded['algo.List'] = List

-- We prefer OO method `get` over builtin indexing operator.
List.__index = List

--- Check whether two lists are equal.
List.__eq = function(o1, o2)
  if type(o1) ~= type(o2) then
    return false
  end

  if o1:len() ~= o2:len() then
    return false
  end

  local ptr1 = o1.head
  local ptr2 = o2.head

  while ptr1 ~= nil do
    if ptr1.data ~= ptr2.data then
      return false
    end

    ptr1 = ptr1.next
    ptr2 = ptr2.next
  end

  return true
end

-- Internal node used in `algo.List`
local Node = {}
Node.__index = Node

function Node:new(data)
  self = {}
  setmetatable(self, Node)
  self.data = data
  self.next = nil
  self.prev = nil
  return self
end

--- Create an empty list.
-- @return An empty list.
function List:new()
  local self = {}
  setmetatable(self, List)
  self.head = nil
  self.tail = nil
  self.current = self.head
  self._size = 0
  return self
end

--- Create a list from an array-style table.
-- @param t an array-style table
-- @return An list with the same size and data of the table
function List:from_table(t)
  local list = List:new(#t)

  for i = 1, #t do
    list:push(t[i])
  end

  return list
end

--- Peek the head of the list.
-- @return the head element in the list, or nil if the list is empty
function List:peek_head()
  if self.head == nil then
    return nil
  else
    return self.head.data
  end
end

--- Peek the tail of the list.
-- @return the tail element in the list, or nil if the list is empty
function List:peek_tail()
  if self.tail == nil then
    return nil
  else
    return self.tail.data
  end
end

--- Index the list
-- @param index the index
-- @return the indexed element, or nil if index out of range
function List:get(index)
  if index < 1 or index > self:len() then
    return nil
  end

  local curr = self.head
  local i = 1
  while i < index do
    curr = curr.next
    i = i + 1
  end

  return curr.data
end

--- Iterate over the list.
-- @return An iterator over the list
function List:next()
  local prev = nil

  return function()
    if self.current ~= nil then
      prev = self.current
      self.current = self.current.next
      return prev.data
    else
      return nil
    end
  end
end

--- Iterator over the list.
-- @return An iterator over the list.
function List:iter()
  return self:next()
end

--- Reset iterator location.
function List:reset()
  self.current = self.head
end

function List:next()
  local prev = nil

  return function ()
    if self.current ~= nil then
      prev = self.current
      self.current = self.current.next
      return prev.data
    else
      return nil
    end
  end
end

function List:map(func)
  local list = List:new()
  local prev = nil
  local curr = self.head

  while curr ~= nil do
    list:push(func(curr.data))
    curr = curr.next
  end

  return list
end

--- Push an element into the tail of the list.
-- @param element the element
function List:push(element)
  local node = Node:new(element)

  if self.head == nil then
    self.head = node
    self.tail = node
    self.current = self.head
  else
    self.tail.next = node
    node.prev = self.tail
    self.tail = node
  end

  self._size = self:len() + 1
end

--- Pop an element from the tail of the list.
-- @return the element, or nil if the list is empty
function List:pop()
  if self.head == nil then
    return nil
  end

  local element = self.tail.data
  if self.head == self.tail then
    self.head = nil
    self.tail = nil
    self.current = self.head
  else
    local prev = nil
    local curr = self.head

    while curr ~= self.tail do
      prev = curr
      curr = curr.next
    end

    curr.prev = nil
    self.tail = prev
    prev.next = nil
  end

  self._size = self:len() - 1
  return element
end

--- Unshift an element into the head of the list.
-- @param element an element
function List:unshift(element)
  local node = Node:new(element)

  if self.head == nil then
    self.head = node
    self.tail = node
  else
    self.head.prev = node
    node.next = self.head
    self.head = node
  end

  self.current = self.head
  self._size = self:len() + 1
end

--- Shift an element from the head of the list.
-- @return an element, or nil if the list is empty.
function List:shift()
  if self.head == nil then
    return nil
  end

  local data = self.head.data

  if self.head == self.tail then
    self.head = nil
    self.tail = nil
  else
    local temp = self.head.next
    temp.prev = nil
    self.head.next = nil
    self.head = temp
  end

  self.current = self.head
  self._size = self:len() - 1
  return data
end

--- Insert an element into the list by the index.
-- @param index the index number
-- @param element an element
function List:insert(index, element)
  assert(1 <= index and index <= self:len() + 1)

  if index == 1 then
    self:unshift(element)
  elseif index == self:len() + 1 then
    self:push(element)
  else
    local i = 1
    local prev = nil
    local curr = self.head

    while i < index do
      prev = curr
      curr = curr.next
      i = i + 1
    end

    local node = Node:new(element)

    node.next = curr
    curr.prev = node

    node.prev = prev
    prev.next = node

    self._size =  self:len() + 1
  end
end

--- The length of the list.
-- @return the length
function List:len()
  return self._size
end

return List
