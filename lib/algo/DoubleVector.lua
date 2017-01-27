--- `algo.DoubleVector` class.
-- A vector with double-precision floating points as it elements, which is
-- implemented in C.  Implicitly called when the elements are numbers.
-- [ffi from LuaJIT](http://luajit.org/ext_ffi.html) is used for binding.
-- @classmod DoubleVector
local ffi = require "ffi"
local util = require "algo.Util"

ffi.cdef([[
  typedef struct {
  size_t size;
  double* vec;
  } DoubleVector;

  DoubleVector* double_vector_new(size_t);
  size_t double_vector_size(DoubleVector*);
  double double_vector_get(DoubleVector*, size_t);
  void double_vector_set(DoubleVector*, size_t, double);
  double double_vector_magnitude(DoubleVector*);
  int double_vector_equal(DoubleVector*, DoubleVector*);
  DoubleVector* double_vector_add(DoubleVector*, DoubleVector*);
  DoubleVector* double_vector_scalar_add(DoubleVector*, double);
  DoubleVector* double_vector_sub(DoubleVector*, DoubleVector*);
  DoubleVector* double_vector_scalar_sub_first(double, DoubleVector*);
  DoubleVector* double_vector_scalar_sub_second(DoubleVector*, double);
  DoubleVector* double_vector_mul(DoubleVector*, DoubleVector*);
  DoubleVector* double_vector_scalar_mul(DoubleVector*, double);
  DoubleVector* double_vector_div(DoubleVector*, DoubleVector*);
  DoubleVector* double_vector_scalar_div_first(double, DoubleVector*);
  DoubleVector* double_vector_scalar_div_second(DoubleVector*, double);
  DoubleVector* double_vector_pow(DoubleVector*, DoubleVector*);
  DoubleVector* double_vector_scalar_pow_first(double, DoubleVector*);
  DoubleVector* double_vector_scalar_pow_second(DoubleVector*, double);
  double double_vector_dot(DoubleVector*, DoubleVector*);
  void double_vector_error(DoubleVector*, const char*);
  void double_vector_free(DoubleVector*);
  char* utoa(unsigned);
  ]])

local cvector = nil
local os_type, _ = util.get_os()

-- Refactor it later.
local version = _VERSION:match("%d+%.%d+")
local prefix = os.getenv("PREFIX") or os.getenv("HOME")
local rockpath_unix = nil
local rockpath_win = nil
if prefix == os.getenv("HOME") then
  rockpath_unix = "/.luarocks/lib/lua/" .. version .. "/"
  rockpath_win = "\\.luarocks\\lib\\lua\\" .. version .. "\\"
else
  rockpath_unix = "/lib/luarocks/lib/lua/" .. version .. "/"
  rockpath_win = "\\lib\\luarocks\\lib\\lua\\" .. version .. "\\"
end

if os_type == "Windows" then
  cvector = ffi.load(prefix .. rockpath_win .. "libdoubleVector.dll")
elseif os_type == "Mac" then
  cvector = ffi.load(prefix .. rockpath_unix .. "libdoubleVector.dylib")
elseif os_type == "Linux" then
  cvector = ffi.load(prefix .. rockpath_unix .. "libdoubleVector.so")
else
  error("Unsupported platform")
end

-- local cvector = ffi.load("libdoubleVector")

local DoubleVector = {}
package.loaded['DoubleVector'] = DoubleVector

DoubleVector.__index = DoubleVector

--- Automatically called when the object is recycled.
DoubleVector.__gc = function (o)
  cvector.double_vector_free(o)
end

--- Check whether two vectors are equal.
DoubleVector.__eq = function (v1, v2)
  if type(v1) ~= type(v2) then
    return false
  end

  assert(type(v1) == "table" and v1["get"] and v1["len"])
  assert(type(v2) == "table" and v2["get"] and v2["len"])

  local n = cvector.double_vector_equal(v1.vec, v2.vec)

  if n ~= 0 then
    return true
  else
    return false
  end
end

-- Create a double vector from raw vector.
local function _vector_from_raw(v)
  local vector = DoubleVector:new(0)
  cvector.double_vector_free(vector.vec)
  vector.vec = v
  return vector
end

--- Vector addition.
-- @param v1 vector or number
-- @param v2 vector or number
-- @return A new vector.
DoubleVector.__add = function (v1, v2)
  local raw = nil
  if type(v1) == "number" and type(v2) == "table" then
    assert(v2["get"] and v2["len"])
    raw = cvector.double_vector_scalar_add(v2.vec, v1)
  elseif type(v1) == "table" and type(v2) == "number" then
    assert(v1["get"] and v1["len"])
    raw = cvector.double_vector_scalar_add(v1.vec, v2)
  else
    assert(type(v1) == "table" and v1["get"] and v1["len"])
    assert(type(v2) == "table" and v2["get"] and v2["len"])

    local len1 = v1:len()
    local len2 = v2:len()
    assert(len1 == len2)

    raw = cvector.double_vector_add(v1.vec, v2.vec)
  end

  return _vector_from_raw(raw)
end

--- Vector substration.
-- @param v1 vector or number
-- @param v2 vector or number
-- @return A new vector.
DoubleVector.__sub = function (v1, v2)
  local raw = nil
  if type(v1) == "number" and type(v2) == "table" then
    assert(v2["get"] and v2["len"])
    raw = cvector.double_vector_scalar_sub_first(v1, v2.vec)
  elseif type(v1) == "table" and type(v2) == "number" then
    assert(v1["get"] and v1["len"])
    raw = cvector.double_vector_scalar_sub_second(v1.vec, v2)
  else
    assert(type(v1) == "table" and v1["get"] and v1["len"])
    assert(type(v2) == "table" and v2["get"] and v2["len"])

    local len1 = v1:len()
    local len2 = v2:len()
    assert(len1 == len2)

    raw = cvector.double_vector_sub(v1.vec, v2.vec)
  end

  return _vector_from_raw(raw)
end

--- Vector multiplication.
-- @param v1 vector or number
-- @param v2 vector or number
-- @return A new vector.
DoubleVector.__mul = function (v1, v2)
  local raw = nil
  if type(v1) == "number" and type(v2) == "table" then
    assert(v2["get"] and v2["len"])
    raw = cvector.double_vector_scalar_mul(v2.vec, v1)
  elseif type(v1) == "table" and type(v2) == "number" then
    assert(v1["get"] and v1["len"])
    raw = cvector.double_vector_scalar_mul(v1.vec, v2)
  else
    assert(type(v1) == "table" and v1["get"] and v1["len"])
    assert(type(v2) == "table" and v2["get"] and v2["len"])

    local len1 = v1:len()
    local len2 = v2:len()
    assert(len1 == len2)

    raw = cvector.double_vector_mul(v1.vec, v2.vec)
  end

  return _vector_from_raw(raw)
end

--- Vector division.
-- @param v1 vector or number
-- @param v2 vector or number
-- @return A new vector.
DoubleVector.__div = function (v1, v2)
  local raw = nil
  if type(v1) == "number" and type(v2) == "table" then
    assert(v2["get"] and v2["len"])
    raw = cvector.double_vector_scalar_div_first(v1, v2.vec)
  elseif type(v1) == "table" and type(v2) == "number" then
    assert(v1["get"] and v1["len"])
    raw = cvector.double_vector_scalar_div_second(v1.vec, v2)
  else
    assert(type(v1) == "table" and v1["get"] and v1["len"])
    assert(type(v2) == "table" and v2["get"] and v2["len"])

    local len1 = v1:len()
    local len2 = v2:len()
    assert(len1 == len2)

    raw = cvector.double_vector_div(v1.vec, v2.vec)
  end

  return _vector_from_raw(raw)
end

--- Vector power.
-- @param v1 vector or number
-- @param v2 vector or number
-- @return A new vector.
DoubleVector.__pow = function (v1, v2)
  local raw = nil
  if type(v1) == "number" and type(v2) == "table" then
    assert(v2["get"] and v2["len"])
    raw = cvector.double_vector_scalar_pow_first(v1, v2.vec)
  elseif type(v1) == "table" and type(v2) == "number" then
    assert(v1["get"] and v1["len"])
    raw = cvector.double_vector_scalar_pow_second(v1.vec, v2)
  else
    assert(type(v1) == "table" and v1["get"] and v1["len"])
    assert(type(v2) == "table" and v2["get"] and v2["len"])

    local len1 = v1:len()
    local len2 = v2:len()
    assert(len1 == len2)

    raw = cvector.double_vector_pow(v1.vec, v2.vec)
  end

  return _vector_from_raw(raw)
end

--- Create a double vector.
-- @param size the size of the vector
-- @return A vector.
function DoubleVector:new(size)
  self = {}
  setmetatable(self, DoubleVector)
  self.vec = cvector.double_vector_new(size)
  return self
end

--- Create a double vector with the elements from an array-style table.
-- @param t an array-style table
-- @return A vector.
function DoubleVector:from_table(t)
  local len = #t
  local vector = DoubleVector:new(len)

  for i = 1, len do
    vector:set(i, t[i])
  end

  return vector
end

--- Index the vector.
-- @param i the index
-- @return The element.
function DoubleVector:get(index)
  return cvector.double_vector_get(self.vec, index - 1)
end

--- Assign an element by indexing the vector.
-- @param index the index
-- @param data the element
function DoubleVector:set(index, data)
  cvector.double_vector_set(self.vec, index - 1, data)
end

--- The length of the vector.
-- @return Length.
function DoubleVector:len()
  return tonumber(cvector.double_vector_size(self.vec))
end

--- The magnitude of the vector.
-- @return Magnitude.
function DoubleVector:magnitude()
  return cvector.double_vector_magnitude(self.vec)
end

--- Dot operation on two vectors
-- @param v a vector
-- @return The result
function DoubleVector:dot(v)
  assert(type(v) == "table" and v["get"] and v["len"])
  local len1 = self:len()
  local len2 = v:len()
  assert(len1 == len2)

  if type(v.vec) == "cdata" then
    return cvector.double_vector_dot(self.vec, v.vec)
  end

  local result = 0
  for i = 1, len1 do
    result = result + self:get(i) * v:get(i)
  end

  return result
end

return DoubleVector
