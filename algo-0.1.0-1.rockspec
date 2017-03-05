-- -*- mode: lua -*-

package = "algo"
version = "0.1.0-1"

source = {
    url = "https://github.com/cwchentw/algo-lua"
}

description = {
  summary = "Common data structures and algorithms in Lua",
  detailed = [[
    This library demostrates several common data structures and algorithms
    mostly in Lua.  Since Lua is a slow language compared to C/C++, you should
    not use this package for critical tasks.  In addition, the package is still
    in alpha stage.  The API may change without warning.

    The package is built partially as a supplement for other libraries; don't
    expect full implementations for all classic algorithms.

    Lua community is split to two major Lua implementations, official Lua and
    LuaJIT. Although LuaJIT is behind official Lua in language features, the
    former outperforms the latter by about 10x-50x.  Therefore, this library
    targets LuaJIT.
    ]],
  homepage = "https://github.com/cwchentw/algo-lua",
  license = "MIT"
}

dependencies = {
  "lua >= 5.1, < 5.3",
  "luafilesystem",
  "luautf8",
}

build = {
  type = "builtin",
  modules = {
    algo = "lib/init.lua",
    ["algo.Array"] = "lib/algo/Array.lua",
    ["algo.List"] = "lib/algo/List.lua",
    ["algo.Stack"] = "lib/algo/Stack.lua",
    ["algo.Queue"] = "lib/algo/Queue.lua",
    ["algo.Iterator"] = "lib/algo/Iterator.lua",
    ["algo.Map"] = "lib/algo/Map.lua",
    ["algo.Set"] = "lib/algo/Set.lua",
    ["algo.Heap"] = "lib/algo/Heap.lua",
    ["algo.NaiveBSTree"] = "lib/algo/NaiveBSTree.lua",
    ["algo.String"] = "lib/algo/String.lua",
    ["algo.LuaString"] = "lib/algo/LuaString.lua",
    ["algo.UTF8String"] = "lib/algo/UTF8String.lua",
    ["algo.Time"] = "lib/algo/Time.lua",
    ["algo.DateTime"] = "lib/algo/DateTime.lua",
    ["algo.Util"] = "lib/algo/Util.lua",
  }
}
