# algo-lua

Algorithms in Lua.

## Notice

This package intends to demonstrate common data structures and algorithms, which
is implemented in Lua.  Don't use it in production environment.

## Introduction

The library demonstrates common data structures and algorithms mostly in Lua.
Since Lua is a slow language compared with C/C++, you should not rely on
this package for critical tasks.  In addition, the module is still in alpha
stage; the API may change without warning.

The package is built partially as a supplement for other libraries; don't
expect full implementations for all classic algorithms.

Lua community is split by two major Lua implementations, official [Lua](https://www.lua.org/)
and [LuaJIT](http://luajit.org/). Although LuaJIT is behind official Lua in
language features, the former outperforms the latter by about 10x-50x.  Therefore,
this library targets LuaJIT.

## Install

After clone the repository, make a LuaRocks package from it.

```
$ git clone https://github.com/cwchentw/algo-lua.git
$ cd algo-lua
$ luarocks make algo-0.1.0-1.rockspec
```

## Documentation

After installation, see the API documentation and their examples in the package
document.

```
$ luarocks doc algo
```

## Copyright

2017, Michael Chen.

## License

algo-lua is free software, using MIT License.
