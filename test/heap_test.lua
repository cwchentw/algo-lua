local Heap = require "algo.Heap"

-- Use algo.Heap as a minimal priority queue
do
  -- MinHeap
  local heap = Heap:from_table({4, 3, 2, 1})

  -- MinHeap: 1 <- 2 <- 3 <- 4
  assert(heap:peek() == 1)
  assert(heap:pop() == 1)

  -- MinHeap: 2 <- 3 <- 4
  assert(heap:peek() == 2)
  assert(heap:pop() == 2)

  -- MinHeap 3 <- 4
  assert(heap:peek() == 3)
  assert(heap:pop() == 3)

  -- MinHeap: 4
  assert(heap:peek() == 4)
  assert(heap:pop() == 4)

  -- MinHeap: empty
  assert(heap:peek() == nil)
  assert(heap:pop() == nil)
end

-- Use algo.Heap as a maximal priority queue
do
  -- MaxHeap
  local heap = Heap:from_table({1, 2, 3, 4}, function (a, b) return a > b end)

  -- MaxHeap: 4 <- 3 <- 2 <- 1
  assert(heap:peek() == 4)
  assert(heap:pop() == 4)

  -- MaxHeap: 3 <- 2 <- 1
  assert(heap:peek() == 3)
  assert(heap:pop() == 3)

  -- MaxHeap: 2 <- 1
  assert(heap:peek() == 2)
  assert(heap:pop() == 2)

  -- MaxHeap: 1
  assert(heap:peek() == 1)
  assert(heap:pop() == 1)

  -- MaxHeap: empty
  assert(heap:peek() == nil)
  assert(heap:pop() == nil)
end
