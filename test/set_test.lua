local Set = require "algo.Set"

-- Create set from table
local set = Set:from_table({'a', 'b', 'c'})
assert(set:contain('a'))
assert(not set:contain('z'))

set = Set:from_table({2, 3, 4, 6})
assert(set:len(), 4)

-- Iterate over the set
local s1 = Set:from_table({'a', 'b', 'c'})
local s = Set:new()
for e in s1:iter() do
  s:insert(e)
end
assert(s:contain('a'))
assert(s:contain('b'))
assert(s:contain('c'))
assert(not s:contain('z'))

-- Remove an element
local set = Set:from_table({'a', 'b', 'c'})
set:remove('a')
assert(not set:contain('a'))
assert(set:contain('b'))
assert(set:contain('c'))
