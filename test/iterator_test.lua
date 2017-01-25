local List = require "algo.List"
local Iterator = require "algo.Iterator"

-- Map on List
do
  local list = List:from_table({1, 2, 3})
  local iter = Iterator:new(list)

  local list_1 = List:new()
  for e in iter:map(function (x) return x * x end) do
    list_1:push(e)
  end
  assert(list_1 == List:from_table({1, 4, 9}))
end

-- Filter on List
do
  local list = List:from_table({1, 2, 3, 4, 5, 6})
  local iter = Iterator:new(list)

  local list_1 = List:new()
  for e in iter:filter(function (x) return x % 2 == 0 end) do
    list_1:push(e)
  end
  assert(list_1 == List:from_table({2, 4, 6}))
end

-- Any on List
do
  local list = List:from_table({1, 2, 3, 4, 5})
  local iter = Iterator:new(list)
  assert(iter:any(function (x) return x % 2 == 0 end))
end

-- Any on List
do
  local list = List:from_table({1, 2, 3, 4, 5})
  local iter = Iterator:new(list)
  assert(iter:any(function (x) return x > 10 end) == false)
end

-- All on List
do
  local list = List:from_table({1, 2, 3, 4, 5})
  local iter = Iterator:new(list)
  assert(iter:all(function (x) return x > 0 end))
end

-- All on List
do
  local list = List:from_table({2, 1, 0, -1, -2})
  local iter = Iterator:new(list)
  assert(iter:all(function (x) return x > 0 end) == false)
end

-- First on List
do
  local list = List:from_table({1, 2, 3, 4, 5})
  local iter = Iterator:new(list)
  assert(iter:first(function (x) return x > 3 end) == 4)
end

-- First on List
do
  local list = List:from_table({1, 2, 3, 4, 5})
  local iter = Iterator:new(list)
  assert(iter:first(function (x) return x > 10 end) == nil)
end

-- Min on List
do
  local list = List:from_table({1, 2, 3})
  local iter = Iterator:new(list)
  assert(iter:max() == 3)
end

-- Min on List
do
  local list = List:from_table({1})
  local iter = Iterator:new(list)
  assert(iter:max() == 1)
end

-- Min on List
list = List:from_table({1, 2, 3})
iter = Iterator:new(list)
assert(iter:min() == 1)

-- Min on List
list = List:from_table({1})
iter = Iterator:new(list)
assert(iter:min() == 1)

-- Reduce on List
do
  local list = List:from_table({1, 2, 3, 4, 5, 6, 7, 8, 9, 10})
  local iter = Iterator:new(list)
  assert(iter:reduce(function (a, b) return a + b end) == 55)
end

-- Zip on Lists
do
  local list = List:from_table({1, 2, 3, 4})
  local iter = Iterator:new(list)
  local next = iter:zip(List:from_table({4, 5, 6}))
  assert(next() == 1, 4)
  assert(next() == 2, 5)
  assert(next() == 3, 6)
  assert(next() == nil, nil)
end

-- Sort on List, default to function (a, b) return a < b end
do
  local list = List:from_table({4, 3, 2, 1})
  local iter = Iterator:new(list)
  local next = iter:sort()
  assert(next() == 1)
  assert(next() == 2)
  assert(next() == 3)
  assert(next() == 4)
  assert(next() == nil)
end

-- Sort on List
do
  local list = List:from_table({1, 2, 3, 4})
  local iter = Iterator:new(list)
  local next = iter:sort(function (a, b) return a > b end)
  assert(next() == 4)
  assert(next() == 3)
  assert(next() == 2)
  assert(next() == 1)
  assert(next() == nil)
end

-- Ipairs on List
local list = List:from_table({'a', 'b', 'c'})
local iter = Iterator:new(list)

local n = 1
for i, e in iter:ipairs() do
  assert(i == n)
  assert(e == list:get(n))
  n = n + 1
end
