local Queue = require "algo.Queue"

local queue = Queue:new()

-- Queue: 1
queue:push(1)
assert(queue:peek_tail() == 1)
assert(queue:peek_head() == 1)

-- Queue: 1 <- 2
queue:push(2)
assert(queue:peek_tail() == 2)
assert(queue:peek_head() == 1)

-- Queue: 1 <- 2 <- 3
queue:push(3)
assert(queue:peek_tail() == 3)
assert(queue:peek_head() == 1)

-- Queue: 2 <- 3; shifted: 1
assert(queue:shift() == 1)
assert(queue:peek_head() == 2)
assert(queue:peek_tail() == 3)

-- Queue: 3; shifted: 2
assert(queue:shift() == 2)
assert(queue:peek_head() == 3)
assert(queue:peek_tail() == 3)

-- Queue: empty; shifted: 3
assert(queue:shift() == 3)
assert(queue:peek_head() == nil)
assert(queue:peek_tail() == nil)

-- Queue: 10
queue:unshift(10)
assert(queue:peek_head() == 10)
assert(queue:peek_tail() == 10)

-- Queue: 20 <- 10
queue:unshift(20)
assert(queue:peek_head() == 20)
assert(queue:peek_tail() == 10)

-- Queue: 30 <- 20 <- 10
queue:unshift(30)
assert(queue:peek_head() == 30)
assert(queue:peek_tail() == 10)

-- Queue: 30 <- 20; popped: 10
assert(queue:pop() == 10)
assert(queue:peek_head() == 30)
assert(queue:peek_tail() == 20)

-- Queue: 30; popped: 20
assert(queue:pop() == 20)
assert(queue:peek_head() == 30)
assert(queue:peek_tail() == 30)

-- Queue: empty; popped: 30
assert(queue:pop() == 30)
assert(queue:peek_head() == nil)
assert(queue:peek_tail() == nil)
