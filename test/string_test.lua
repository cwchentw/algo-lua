local String = require "algo.String"
local Array = require "algo.Array"

-- String presentation.
local s = String:new("你好，麥可")
assert(string.format("%s", s) == "你好，麥可")

-- Iterate over the string object.
local a = Array:from_table({"你", "好", "，", "麥", "可"})
local i = 1
for e in s:iter() do
  assert(e:raw() == a:get(i))
  i = i + 1
end

-- Insert a substring.
local s = String:new("你好，麥可")
local s = s:insert(1, "早安")
assert(s:raw() == "早安你好，麥可")

local s = String:new("你好，") .. String:new("麥可")
assert(s:raw() == "你好，麥可")

-- String length
local s = String:new("你好，麥可")
assert(s:len() == 5)
-- Builtin length operator `#` doesn't work on LuaJIT
-- assert(#s == 5)

-- Reverse a string
do
  local s = String:new("阿囉哈")
  assert(s:reverse():raw() == "哈囉阿")
end

-- Remove substring
do
  local s = String:new("你好，麥可")
  local s = s:remove(3, 5)
  assert(s:raw() == "你好")
end
