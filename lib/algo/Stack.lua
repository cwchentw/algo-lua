--- `algo.Stack` class.
-- A stack which uses a doubly-linked list internally.  The official Lua book,
-- *Programming in Lua*, introduces a table based stack implementation, but
-- implementing stack with associatory array is not a common scheme.  Therefore,
-- we still uses linked-list in our stack implementation.
-- @classmod Stack
local List = require "algo.List"
-- Inherit methods from List
local Stack = { __index = List }
package.loaded['algo.Stack'] = Stack

--- Create an empty stack.
-- @return An empty stack.
function Stack:new()
  self = List:new()
  return self
end

--- Create a stack with an array-style table.
-- @return An stack with the elements from the table
function Stack:from_table(table)
  local stack = Stack:new()
  for _, v in pairs(table) do
    stack:push(v)
  end
  return stack
end

--- Peek the element in the top of the stack.
-- @return The element
function Stack:peek()
  return self:peek()
end

-- We need to add peek method for our List
-- or our Stack could not trace this method.
function List:peek()
  return self:peek_tail()
end

--- Push an element into the top of the stack.
-- @param element the element
function Stack:push(element)
  return self:push(element)
end

--- Pop an element from the top of the stack.
-- @return an element, or nil if the stack is empty
function Stack:pop()
  return self:pop()
end

return Stack
