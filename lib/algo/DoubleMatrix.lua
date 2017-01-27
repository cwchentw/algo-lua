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
double double_matrix_get_row(DoubleMatrix*);
double double_matrix_get_col(DoubleMatrix*);
void double_matrix_free(DoubleMatrix*);
]])

local cmatrix = Util:ffi_load(ffi, "libdoubleMatrix")

local DoubleMatrix = {}
package.loaded['DoubleMatrix'] = DoubleMatrix

DoubleMatrix.__index = DoubleMatrix

DoubleMatrix.__gc = function (m)
  cmatrix.double_matrix_free(m.mtx)
end

--- Create a matrix with specific dimension.
-- @param nrow row size
-- @param ncol col size
-- @return A matrix (object).
function DoubleMatrix:new(nrow, ncol)
  assert(nrow > 0 and ncol > 0)

  self = {}
  setmetatable(self, DoubleMatrix)
  self.mtx = cmatrix.double_matrix_new(nrow, ncol);

  return self
end

--- Get the row size of the matrix.
-- @return Row size (number).
function DoubleMatrix:row()
  return cmatrix.double_matrix_get_row(self.mtx)
end

--- Get the column size of the matrix.
-- @return Column size (number).
function DoubleMatrix:col()
  return cmatrix.double_matrix_get_col(self.mtx)
end

return DoubleMatrix
