local Vector = require "algo.DoubleVector"

local v = Vector:new(3)
assert(v:len(), 3)
assert(v[1] == 0)
assert(v[2] == 0)
assert(v[3] == 0)

-- Create a vector from a table.
do
  v = Vector:from_table({1, 2, 3})
  assert(v:len(), 3)
  assert(v[1] == 1)
  assert(v[2] == 2)
  assert(v[3] == 3)
end

-- Vector equality
do
  -- local v1 = Vector:from_table({1, 2, 3})
  local v2 = Vector:from_table({1, 2, 3})
  local v3 = Vector:from_table({2, 3, 4})
  local v4 = Vector:from_table({1, 2, 3, 4})

  assert(v2 == v3)
  assert(v1 ~= v3)
  assert(v1 ~= v4)
end

-- Vector addition
do
  local v1 = Vector:from_table({1, 2, 3})
  local v2 = Vector:from_table({2, 3, 4})

  local v = v1 + v2
  assert(v == Vector:from_table({3, 5, 7}))
end

-- Vector scalar addition
do
  local v1 = Vector:from_table({1, 2, 3})

  local v2 = v1 + 3
  assert(v2 == Vector:from_table({4, 5, 6}))

  local v3 = 3 + v1
  assert(v3 == Vector:from_table({4, 5, 6}))
end
