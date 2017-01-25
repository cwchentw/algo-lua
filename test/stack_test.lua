local Stack = require "algo.Stack"

-- Stack: empty
local stack = Stack:new()

-- Stack: 1
stack:push(1)
assert(stack:peek() == 1)

-- Stack: 1 <- 2
stack:push(2)
assert(stack:peek() == 2)

-- Stack: 1 <- 2 <- 3
stack:push(3)
assert(stack:peek() == 3)

-- Stack: 1 <- 2; popped: 3
assert(stack:pop() == 3)

-- Stack: 1; popped = 2
assert(stack:pop() == 2)

-- Stack: empty; popped = 1
assert(stack:pop() == 1)

-- Stack: empty
assert(stack:pop() == nil)

-- Stack: 1 <- 2 <- 3
stack = Stack:from_table({1, 2, 3})
assert(stack:pop() == 3)
assert(stack:pop() == 2)
assert(stack:pop() == 1)
