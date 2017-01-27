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

double double_matrix_get_row(DoubleMatrix* m) {
  return m->nrow;
}

double double_matrix_get_col(DoubleMatrix* m) {
  return m->ncol;
}

void double_matrix_free(DoubleMatrix* m) {
  if (m == NULL) {
    return;
  }

  free(m->mtx);
  free(m);
}
