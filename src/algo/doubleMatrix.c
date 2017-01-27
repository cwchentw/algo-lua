#include <stdlib.h>
#include <stdio.h>
#include "doubleMatrix.h"
#include "doubleVector.h"

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

double double_matrix_get_nrow(DoubleMatrix* m) {
  return m->nrow;
}

double double_matrix_get_ncol(DoubleMatrix* m) {
  return m->ncol;
}

double double_matrix_get(DoubleMatrix* m, size_t row, size_t col) {
  if (0 > row || row > m->nrow - 1) {
    fprintf(stderr, "Row out of size, invalid data\n");
    return 0.0;
  }

  if (0 > col || col > m->ncol - 1) {
    fprintf(stderr, "Column out of size, invalid data\n");
    return 0.0;
  }

  return m->mtx[row + m->nrow * col];
}

void double_matrix_set(DoubleMatrix* m, size_t row, size_t col, double data) {
  if (0 > row || row > m->nrow - 1) {
    fprintf(stderr, "Row out of size, invalid operation\n");
    return;
  }

  if (0 > col || col > m->ncol - 1) {
    fprintf(stderr, "Column out of size, invalid operation\n");
    return;
  }

  m->mtx[row + m->nrow * col] = data;
}

DoubleVector* double_matrix_get_row(DoubleMatrix* m, size_t row) {
  if (0 > row || row > m->nrow - 1) {
    fprintf(stderr, "Row out of size, invalid operation\n");
    return NULL;
  }

  DoubleVector* vec = double_vector_new(m->ncol);

  size_t col = m->ncol;
  for (int i = 0; i < col; i++) {
    double_vector_set(vec, i, double_matrix_get(m, row, i));
  }

  return vec;
}

DoubleVector* double_matrix_get_col(DoubleMatrix* m, size_t col) {
  if (0 > col || col > m->ncol - 1) {
    fprintf(stderr, "Column out of size, invalid operation\n");
    return NULL;
  }

  DoubleVector* vec = double_vector_new(m->nrow);

  size_t row = m->nrow;
  for (int i = 0; i < row; i++) {
    double_vector_set(vec, i, double_matrix_get(m, i, col));
  }

  return vec;
}

void double_matrix_free(DoubleMatrix* m) {
  if (m == NULL) {
    return;
  }

  free(m->mtx);
  free(m);
}
