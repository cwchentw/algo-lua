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
double double_matrix_get_nrow(DoubleMatrix*);
double double_matrix_get_ncol(DoubleMatrix*);
double double_matrix_get(DoubleMatrix*, size_t, size_t);
void double_matrix_set(DoubleMatrix*, size_t, size_t, double);
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
  return cmatrix.double_matrix_get_nrow(self.mtx)
end

--- Get the column size of the matrix.
-- @return Column size (number).
function DoubleMatrix:col()
  return cmatrix.double_matrix_get_ncol(self.mtx)
end

--- Index matrix by (row, col) pair
-- @param row Row, 1-based number
-- @param col Column, 1-based number
-- @return Data (number).
function DoubleMatrix:get(row, col)
  local nrow = self:row()
  assert(1 <= row and row <= nrow)

  local ncol = self:col()
  assert(1 <= col and col <= ncol)

  return cmatrix.double_matrix_get(self.mtx, row, col)
end

--- Assign data to the matrix by (row, col) pair.
-- @param row, Row, 1-based number
-- @param col, Column, 1-based number
-- @param data, Data (number)
function DoubleMatrix:set(row, col, data)
  local nrow = self:row()
  assert(1 <= row and row <= nrow)

  local ncol = self:col()
  assert(1 <= col and col <= ncol)

  assert(type(data) == "number")

  cmatrix.double_matrix_set(self.mtx, row, col, data)
end

return DoubleMatrix
