local Array = require "algo.Array"

-- Create an new array with specific size
do
  -- Array: 0, 0, 0
  local array = Array:new(3)
  -- assert(#array == 3)
  assert(array:len() == 3)
  assert(array[1] == 0)
  assert(array[2] == 0)
  assert(array[3] == 0)
end

-- Create an array from an array-style table
do
  -- Array: 1, 2, 3
  local array = Array:from_table({1, 2, 3})
  assert(array:len() == 3)
  assert(array[1] == 1)
  assert(array[2] == 2)
  assert(array[3] == 3)
  assert(string.format("%s", array) == "(1, 2, 3)")
end

-- Peak the elements in the array
do
  -- Array: 1, 2, 3
  local array = Array:from_table({1, 2, 3})
  assert(array:peek_head() == 1)
  assert(array:peek_tail() == 3)
end

-- Peak the elements in the array
do
  -- Array: empty
  local array = Array:new(0)
  assert(array:peek_head() == nil)
  assert(array:peek_tail() == nil)
end

-- Iterate over the array
do
  -- Array: 1, 2, 3
  local array = Array:from_table({1, 2, 3})
  local array_1 = Array:new(3)

  local i = 1
  for e in array:iter() do
    array_1[i] = e
    i = i + 1
  end
  assert(array_1:len() == 3)
  assert(array_1[1] == 1)
  assert(array_1[2] == 2)
  assert(array_1[3] == 3)
end

-- Push elements into the array
do
  -- Array: empty
  local array = Array:new(0)

  -- Array: 1
  array:push(1)
  assert(array:len() == 1)
  assert(array[1] == 1)

  -- Array: 1, 2
  array:push(2)
  assert(array:len() == 2)
  assert(array[1] == 1)
  assert(array[2] == 2)

  -- Array: 1, 2, 3
  array:push(3)
  assert(array:len() == 3)
  assert(array[1] == 1)
  assert(array[2] == 2)
  assert(array[3] == 3)
end

-- Pop elements from the array
do
  -- Array: 1, 2, 3
  local array = Array:from_table({1, 2, 3})
  assert(string.format("%s", array) == "(1, 2, 3)")

  -- Array: 1, 2; popped: 3
  assert(array:pop() == 3)
  assert(array:len() == 2)

  -- Array: 1; popped: 2
  assert(array:pop() == 2)
  assert(array:len() == 1)

  -- Array: empty; popped: 1
  assert(array:pop() == 1)
  assert(array:len() == 0)

  -- Array: empty
  assert(array:pop() == nil)
end

-- Unshift elements into the array
do
  -- Array: empty
  local array = Array:new(0)

  -- Array: 1
  array:unshift(1)
  assert(array:len() == 1)
  assert(array[1] == 1)

  -- Array: 2, 1
  array:unshift(2)
  assert(string.format("%s", array) == "(2, 1)")

  -- Array: 3, 2, 1
  array:unshift(3)
  assert(string.format("%s", array) == "(3, 2, 1)")
end

-- Shift elements from the array
do
  -- Array: 11, 22, 33
  local array = Array:from_table({11, 22, 33})
  assert(string.format("%s", array) == "(11, 22, 33)")

  -- Array: 22, 33; shifted: 11
  assert(array:shift() == 11)
  assert(array:len() == 2)
  assert(string.format("%s", array) == "(22, 33)")

  -- Array: 33; shifted: 22
  assert(array:shift() == 22)
  assert(array:len() == 1)

  -- Array: empty; shifted: 33
  assert(array:shift() == 33)
  assert(array:len() == 0)

  -- Array: empty
  assert(array:shift() == nil)
end

-- Insert an element into the head of the array
do
  -- Array: 1, 2, 3
  local array = Array:from_table({1, 2, 3})

  -- Array: 10, 1, 2, 3
  array:insert(1, 10)
  assert(string.format("%s", array) == "(10, 1, 2, 3)")
  -- assert(#array == 4)
  assert(array[1] == 10)
  assert(array[2] == 1)
  assert(array[3] == 2)
  assert(array[4] == 3)
end

-- Insert an element into the tail of the array
do
  -- Array: 1, 2, 3
  local array = Array:from_table({1, 2, 3})

  -- Array: 1, 2, 3, 10
  array:insert(4, 10)
  assert(string.format("%s", array) == "(1, 2, 3, 10)")
  assert(array:len() == 4)
  assert(array[1] == 1)
  assert(array[2] == 2)
  assert(array[3] == 3)
  assert(array[4] == 10)
end

-- Insert an element into the middle of the array
do
  -- Array: 1, 2, 3
  local array = Array:from_table({1, 2, 3})

  -- Array: 1, 10, 2, 3
  array:insert(2, 10)
  assert(string.format("%s", array) == "(1, 10, 2, 3)")
  assert(array:len() == 4)
  assert(array[1] == 1)
  assert(array[2] == 10)
  assert(array[3] == 2)
  assert(array[4] == 3)
end
