local Map = require "algo.Map"
local Set = require "algo.Set"

-- Index value by key
do
  local map = Map:from_table({one = "eins", two = "zwei", three = "drei"})
  assert(map:get("one") == "eins")
end

-- Insert (key, value) into the map
do
  local map = Map:new()
  map:insert("one", "eins")
  assert(map:get("one") == "eins")
end

-- Iterate over the map.
do
  local m1 = Map:from_table({one = "eins", two = "zwei", three = "drei"})
  local m2 = Map:new()

  for k, v in m1:iter() do
    m2:insert(k, v)
  end

  assert(m2:get("one") == "eins")
  assert(m2:get("two") == "zwei")
  assert(m2:get("three") == "drei")
end
