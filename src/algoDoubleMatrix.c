#include <stdlib.h>
#include <stdio.h>
#include "algoDoubleMatrix.h"
#include "algoDoubleVector.h"

DoubleMatrix* algo_double_matrix_new(size_t nrow, size_t ncol) {
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

double algo_double_matrix_get_nrow(DoubleMatrix* m) {
  return m->nrow;
}

double algo_double_matrix_get_ncol(DoubleMatrix* m) {
  return m->ncol;
}

double algo_double_matrix_get(DoubleMatrix* m, size_t row, size_t col) {
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

void algo_double_matrix_set(DoubleMatrix* m, size_t row, size_t col, double data) {
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

DoubleVector* algo_double_matrix_get_row(DoubleMatrix* m, size_t row) {
  if (0 > row || row > m->nrow - 1) {
    fprintf(stderr, "Row out of size, invalid operation\n");
    return NULL;
  }

  DoubleVector* vec = algo_double_vector_new(m->ncol);

  size_t col = m->ncol;
  for (int i = 0; i < col; i++) {
    algo_double_vector_set(vec, i, algo_double_matrix_get(m, row, i));
  }

  return vec;
}

DoubleVector* algo_double_matrix_get_col(DoubleMatrix* m, size_t col) {
  if (0 > col || col > m->ncol - 1) {
    fprintf(stderr, "Column out of size, invalid operation\n");
    return NULL;
  }

  DoubleVector* vec = algo_double_vector_new(m->nrow);

  size_t row = m->nrow;
  for (int i = 0; i < row; i++) {
    algo_double_vector_set(vec, i, algo_double_matrix_get(m, i, col));
  }

  return vec;
}

void algo_double_matrix_free(DoubleMatrix* m) {
  if (m == NULL) {
    return;
  }

  free(m->mtx);
  free(m);
}
