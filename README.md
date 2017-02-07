# algo-lua

Algorithms in Lua.

## Introduction

The library demonstrates common data structures and algorithms mostly in Lua.
Since Lua is a slow language compared with C/C++, you should not rely on
this module for critical tasks.  In addition, the module is still in alpha
stage; the API may change without warning.

The package is built partially as a supplement for other libraries; don't
expect full implementations for classic algorithms.

Lua community is split by two major Lua implementations, official [Lua](https://www.lua.org/)
and [LuaJIT](http://luajit.org/). Although LuaJIT is behind official Lua in
language features, the former outperforms the latter by about 10x-50x.  Therefore,
this library targets LuaJIT.

## Install

Pending.

## Documentation

After installation, see the API documentation and their examples in the module
document.

```
$ luarocks doc algo
```

## Copyright

2017, Michael Chen.

## License

algo-lua is free software, using MIT License.
