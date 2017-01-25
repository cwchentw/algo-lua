--- `algo.Queue` class.
-- A deque which uses a doubly-linked list internally. The official Lua book,
-- *Programming in Lua*, introduces a table based queue implementation, but
-- implementing queue with associatory array is not a common scheme.  Therefore,
-- we still uses linked-list in our queue implementation.
-- @classmod Queue
local List = require "algo.List"
local Queue = { __index = List }
package.loaded['algo.Queue']= Queue

--- Create an empty deque
-- @return An empty deque
function Queue:new()
  self = List:new()
  return self
end

--- Create a queue from an array-style table.
-- @param table an array-style table
-- @return An deque with the elements from the table.
function Queue:from_table(table)
  return self:from_table(table)
end

--- Peek the tail element of the queue.
-- @return The element, or nil if the queue is empty
function Queue:peek_tail()
  return self:peek_tail()
end

--- Peek the head element of the queue.
-- @return The element, or nil if the queue is empty
function Queue:peek_head()
  return self:peek_head()
end

--- Push an element into the tail of the queue.
-- @param element An element
function Queue:push(element)
  self:push(element)
end

--- Pop an element from the tail of the queue.
-- @return An element, or nil if the stack is empty
function Queue:pop()
  return self:pop()
end

--- Unshift an element into the head of the queue.
-- @param element An element
function Queue:unshift(element)
  self:unshift(element)
end

--- Shift an element from the head of the queue.
-- @return An element, or nil if the queue is empty.
function Queue:shift()
  return self:shift()
end

return Queue
