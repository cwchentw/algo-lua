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
