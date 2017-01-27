#include <stdlib.h>
#include "doubleMatrix.h"

DoubleMatrix* double_matrix_new(size_t nrow, size_t ncol) {
  DoubleMatrix* matrix = malloc(sizeof(DoubleMatrix));

  matrix->nrow = nrow;
  matrix->ncol = ncol;
  size_t size = matrix->nrow * matrix->ncol;
  matrix->mtx = malloc(size * sizeof(double));

  for (int i = 0; i < size; i++) {
    matrix->mtx[i] = 0.0;
  }
  
  return matrix;
}

void double_matrix_free(DoubleMatrix* m) {
  if (m == NULL) {
    return;
  }

  free(m->mtx);
  free(m);
}
