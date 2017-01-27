#include <stdlib.h>
#include "doubleMatrix.h"

DoubleMatrix* double_matrix_new(size_t nrow, size_t ncol) {
  DoubleMatrix* matrix = malloc(sizeof(DoubleMatrix));

  matrix->nrow = nrow;
  matrix->ncol = ncol;

  matrix->mtx = malloc(matrix->nrow * matrix->ncol * sizeof(double));

  return matrix;
}

void double_matrix_free(DoubleMatrix* m) {
  if (m == NULL) {
    return;
  }

  free(m->mtx);
  free(m);
}
