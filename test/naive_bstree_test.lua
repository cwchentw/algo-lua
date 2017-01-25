local BSTree = require "algo.NaiveBSTree"

-- Find an element in the tree.
do
  local tree = BSTree:from_table({3, 2, 6, 5, 1, 4})
  assert(tree:contain(1))
  assert(tree:contain(2))
  assert(tree:contain(3))
  assert(tree:contain(4))
  assert(tree:contain(5))
  assert(tree:contain(6))
  assert(tree:contain(10) == false)
end

-- Find an element by func in the tree.
do
  local tree = BSTree:from_table({'c', 'b', 'f', 'e', 'a', 'd'},
    function (x) return string.byte(x) end)
  assert(tree:contain('a'))
  assert(tree:contain('b'))
  assert(tree:contain('c'))
  assert(tree:contain('d'))
  assert(tree:contain('e'))
  assert(tree:contain('f'))
  assert(tree:contain('z') == false)
end

-- Find maximum and minimum in the tree.
do
  local tree = BSTree:from_table({3, 2, 6, 5, 1, 4})
  assert(tree:max() == 6)
  assert(tree:min() == 1)
end

-- Remove an element from the tree.
do
  local tree = BSTree:from_table({3, 2, 6, 5, 1, 4, 8})
  assert(tree:contain(1))
  assert(tree:contain(2))
  assert(tree:contain(3))
  assert(tree:contain(4))
  assert(tree:contain(5))
  assert(tree:contain(6))
  assert(tree:contain(8))

  tree:remove(4)
  assert(tree:contain(4) == false)

  tree:remove(2)
  assert(tree:contain(2) == false)
  assert(tree:contain(1))

  tree:remove(6)
  assert(tree:contain(6) == false)
  assert(tree:contain(5))
  assert(tree:contain(8))
end

-- Remove maximum from the tree.
do
  local tree = BSTree:from_table({3, 2, 6, 5, 1, 4, 8})
  local max = tree:pop_max()
  assert(max == 8)
  assert(tree:contain(max) == false)
  assert(tree:contain(1))
  assert(tree:contain(2))
  assert(tree:contain(3))
  assert(tree:contain(4))
  assert(tree:contain(5))
  assert(tree:contain(6))

  max = tree:pop_max()
  assert(max == 6)
  assert(tree:contain(max) == false)
  assert(tree:contain(1))
  assert(tree:contain(2))
  assert(tree:contain(3))
  assert(tree:contain(4))
  assert(tree:contain(5))

  max = tree:pop_max()
  assert(max == 5)
  assert(tree:contain(max) == false)
  assert(tree:contain(1))
  assert(tree:contain(2))
  assert(tree:contain(3))
  assert(tree:contain(4))
end
