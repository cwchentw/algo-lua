local String = require "algo.String"
local Array = require "algo.Array"

-- String presentation.
do
  local s = String:new("你好，麥可", { encoding = "utf8" })
  assert(string.format("%s", s) == "你好，麥可")
end

-- Iterate over the string object.
do
  local s = String:new("你好，麥可", { encoding = "utf8" })
  local a = Array:from_table({"你", "好", "，", "麥", "可"})
  local i = 1
  for e in s:iter() do
    assert(e:raw() == a:get(i))
    i = i + 1
  end
end

-- Insert a substring.
do
  local s = String:new("你好，麥可", { encoding = "utf8" })
  local s = s:insert(1, "早安")
  assert(s:raw() == "早安你好，麥可")
end

-- Concatenate strings
do
  local s = String:new("你好，", { encoding = "utf8" })
    .. String:new("麥可", { encoding = "utf8" })
  assert(s:raw() == "你好，麥可")
end

-- String length
do
  local s = String:new("你好，麥可", { encoding = "utf8" })
  assert(s:len() == 5)
  -- Builtin length operator `#` doesn't work on LuaJIT
  -- assert(#s == 5)
end

-- Reverse a string
do
  local s = String:new("阿囉哈", { encoding = "utf8" })
  assert(s:reverse():raw() == "哈囉阿")
end

-- Remove substring
do
  local s = String:new("你好，麥可", { encoding = "utf8" })
  local s = s:remove(3, 5)
  assert(s:raw() == "你好")
end
