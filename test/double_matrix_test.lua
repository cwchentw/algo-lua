local Matrix = require "algo.DoubleMatrix"

-- Create a matrix
do
  local m = Matrix:new(3, 4)
  assert(m)
  assert(m:row() == 3)
  assert(m:col() == 4)
end

-- Setter and getter
do
  local m = Matrix:new(3, 4)
  assert(math.abs(m:get(1, 1) - 0) < 1e-6)
  assert(math.abs(m:get(3, 4) - 0) < 1e-6)

  m:set(1, 1, 99)
  assert(math.abs(m:get(1, 1) - 99) < 1e-6)

  m:set(3, 4, -99)
  assert(math.abs(m:get(3, 4) - -99) < 1e-6)
end
