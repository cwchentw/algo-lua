local Matrix = require "algo.DoubleMatrix"

-- Create a matrix
do
  local m = Matrix:new(3, 4)
  assert(m)
  assert(m:row() == 3)
  assert(m:col() == 4)
end
