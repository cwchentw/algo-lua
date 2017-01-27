#include <stdlib.h>
#include <stdio.h>
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

double double_matrix_get(DoubleMatrix* m, size_t row, size_t col) {
  if (row > m->nrow) {
    fprintf(stderr, "Index of row out of size, invalid data\n");
    return 0.0;
  }

  if (col > m->ncol) {
    fprintf(stderr, "Index of row out of size, invalid data\n");
    return 0.0;
  }

  return m->mtx[(row - 1) + m->nrow * (col - 1)];
}

void double_matrix_set(DoubleMatrix* m, size_t row, size_t col, double data) {
  if (row > m->nrow) {
    fprintf(stderr, "Index of row out of size, invalid operation\n");
    return;
  }

  if (col > m->ncol) {
    fprintf(stderr, "Index of row out of size, invalid operation\n");
    return;
  }

  m->mtx[(row - 1) + m->nrow * (col - 1)] = data;
}

void double_matrix_free(DoubleMatrix* m) {
  if (m == NULL) {
    return;
  }

  free(m->mtx);
  free(m);
}
