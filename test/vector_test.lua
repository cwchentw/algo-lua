local Vector = require "algo.Vector"

local v = Vector:new(3)
assert(v:len(), 3)
assert(v[1] == 0)
assert(v[2] == 0)
assert(v[3] == 0)

v = Vector:from_table({1, 2, 3})
assert(v:len(), 3)
assert(v[1] == 1)
assert(v[2] == 2)
assert(v[3] == 3)

-- Vector equality
do
  local v1 = Vector:from_table({1, 2, 3})
  local v2 = Vector:from_table({1, 2, 3})
  local v3 = Vector:from_table({2, 3, 4})
  local v4 = Vector:from_table({1, 2, 3, 4})

  assert(v1 == v2)
  assert(v1 ~= v3)
  assert(v1 ~= v4)
end

-- vector addition
local v1 = Vector:from_table({1, 2, 3})
local v2 = Vector:from_table({2, 3, 4})
v = v1 + v2
assert(#v, 3)
assert(v[1] == 3)
assert(v[2] == 5)
assert(v[3] == 7)

-- vector substration
v = v1 - v2
assert(#v, 3)
assert(v[1] == -1)
assert(v[2] == -1)
assert(v[3] == -1)

-- vector multiplication
v = v1 * v2
assert(v:len(), 3)
assert(v[1] == 2)
assert(v[2] == 6)
assert(v[3] == 12)

-- vector division
v = v1 / v2
assert(#v, 3)
assert(math.abs(v[1] - 0.5) < 1 / 1000000)
assert(math.abs(v[2] - 0.6666667) < 1 / 1000000)
assert(math.abs(v[3] - 0.75) < 1 / 1000000)
