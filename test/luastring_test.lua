local String = require "algo.String"
local Array = require "algo.Array"

-- String presentation.
do
  local s = String:new("Hello, World")
  assert(string.format("%s", s) == "Hello, World")
end

-- Iterate over the string object.
do
  local s = String:new("Hello")
  local a = Array:from_table({"H", "e", "l", "l", "o"})
  local i = 1
  for e in s:iter() do
    assert(e:raw() == a:get(i))
    i = i + 1
  end
end

-- Insert a substring.
do
  local s = String:new("Michael")
  s = s:insert(1, "Hello, ")

  assert(s:raw() == "Hello, Michael")
end

-- Insert a substring at tail.
do
  local s = String:new("Hello ")
  s = s:insert("World")

  assert(s:raw() == "Hello World")
end

-- Insert a substring at middle
do
  local s = String:new("Box")
  s = s:insert(2, "usy F")

  assert(s:raw() == "Busy Fox")
end

-- Concatenate strings
do
  local s = String:new("Hello ") .. String:new("World")
  assert(s:raw() == "Hello World")
end

-- String length
do
  local s = String:new("Hello")
  assert(s:len() == 5)
end

-- Remove substring
do
  local s = String:new("Hello World")
  assert(s:remove(1, 6):raw() == "World")
  assert(s:remove(6):raw() == "Hello")
  assert(s:remove():raw() == "Hello Worl")
end

-- Split string
do
  local s = String:new("/home/user/.luarocks/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/?.so;./?.so")
  local f = s:split(";")
  assert(f():raw() == "/home/user/.luarocks/lib/lua/5.1/?.so")
  assert(f():raw() == "/usr/local/lib/lua/5.1/?.so")
  assert(f():raw() == "./?.so")
end
