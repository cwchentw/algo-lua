--- `algo.DoubleMatrix` class.
-- A matrix with the elements of double-precision floating points, which is
-- implemented in C.  Implicitly called when the elements are numbers.
-- [ffi from LuaJIT](http://luajit.org/ext_ffi.html) is used for binding.
-- @classmod DoubleMatrix
local ffi = require "ffi"
local Util = require "algo.Util"

ffi.cdef([[
typedef struct DoubleMatrix {
  size_t nrow;
  size_t ncol;
  double* mtx;
} DoubleMatrix;

DoubleMatrix* double_matrix_new(size_t, size_t);
void double_matrix_free(DoubleMatrix*);
]])

local cmatrix = Util:ffi_load(ffi, "libdoubleMatrix")

local DoubleMatrix = {}
package.loaded['DoubleMatrix'] = DoubleMatrix

DoubleMatrix.__index = DoubleMatrix

return DoubleMatrix
