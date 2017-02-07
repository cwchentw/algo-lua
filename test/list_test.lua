local List = require "algo.List"

-- list: empty
local list = List:new()

-- List: 1
list:push(1)
assert(list:len() == 1)
assert(list:get(1) == 1)

-- List: 1 -> 2
list:push(2)
assert(list:len() == 2)
assert(list:get(1) == 1)
assert(list:get(2) == 2)

-- List: 1 -> 2 -> 3
list:push(3)
assert(list:len() == 3)
assert(list:get(1) == 1)
assert(list:get(2) == 2)
assert(list:get(3) == 3)

-- List: 1 -> 2 -> 3
list = List:from_table({1, 2, 3})

-- List: 1 -> 2; popped: 3
assert(list:pop() == 3)
assert(list:len() == 2)

-- list: 1; popped: 2
assert(list:pop() == 2)
assert(list:len() == 1)

-- list: empty; popped: 1
assert(list:pop() == 1)
assert(list:len() == 0)

-- List: empty
assert(list:pop() == nil)

-- List: empty
list = List:new(0)

-- List: 10
list:unshift(10)
assert(list:len() == 1)
assert(list:get(1) == 10)

-- List: 11 -> 10
list:unshift(11)
assert(list:len() == 2)
assert(list:get(1) == 11)
assert(list:get(2) == 10)

-- List: 12 -> 11 -> 10
list:unshift(12)
assert(list:len() == 3)
assert(list:get(1) == 12)
assert(list:get(2) == 11)
assert(list:get(3) == 10)

-- List: 1 -> 2 -> 3
list = List:from_table({1, 2, 3})

-- List: 2 -> 3; shifted: 1
assert(list:shift() == 1)
assert(list:len() == 2)

-- List: 3; shifted: 2
assert(list:shift() == 2)
assert(list:len() == 1)

-- List: empty: shifted: 3
assert(list:shift() == 3)
assert(list:len() == 0)

-- List: empty
assert(list:shift() == nil)

-- List: 1 -> 2 -> 3
list = List:from_table({1, 2, 3})
assert(list:get(1) == 1)
assert(list:get(2) == 2)
assert(list:get(3) == 3)

-- List: 1 -> 2 -> 3
-- List_1: empty
list = List:from_table({1, 2, 3})
local list_1 = List:new(0)

-- List_1: 1 -> 2 -> 3
for e in list:iter() do
  list_1:push(e)
end
assert(list_1:len() == 3)
assert(list_1:get(1) == 1)
assert(list_1:get(2) == 2)
assert(list_1:get(3) == 3)

-- List: 1 -> 2 -> 3
list = List:from_table({1, 2, 3})

-- List: 100 -> 1 -> 2 -> 3
list:insert(1, 100)
assert(list:get(1) == 100)
assert(list:get(2) == 1)
assert(list:len() == 4)

-- List: 100 -> 1 -> 2 -> 3 -> 200
list:insert(5, 200)
assert(list:get(4) == 3)
assert(list:get(5) == 200)
assert(list:len() == 5)

-- List: 100 -> 1 -> 300 -> 2 -> 3 -> 200
list:insert(3, 300)
assert(list:get(3) == 300)
assert(list:get(4) == 2)
assert(list:len() == 6)
assert(list:peek_head() == 100)
assert(list:peek_tail() == 200)

list = list:from_table({1, 2, 3})
list_1 = list:map(function (x) return x * x end)
assert(list_1 == list:from_table({1, 4, 9}))
