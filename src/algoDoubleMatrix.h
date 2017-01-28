#ifndef __ALGO_DOUBLE_MATRIX_H__
#define __ALGO_DOUBLE_MATRIX_H__

#ifdef __cplusplus
#include <cstddef>
#else
#include <stddef.h>
#endif

#include "algoDoubleVector.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct DoubleMatrix {
  size_t nrow;
  size_t ncol;
  double* mtx;
} DoubleMatrix;

DoubleMatrix* algo_double_matrix_new(size_t, size_t);
double algo_double_matrix_get_nrow(DoubleMatrix*);
double algo_double_matrix_get_ncol(DoubleMatrix*);
double algo_double_matrix_get(DoubleMatrix*, size_t, size_t);
void algo_double_matrix_set(DoubleMatrix*, size_t, size_t, double);
DoubleVector* algo_double_matrix_get_row(DoubleMatrix*, size_t);
DoubleVector* algo_double_matrix_get_col(DoubleMatrix*, size_t);
void algo_double_matrix_free(DoubleMatrix*);

#ifdef __cplusplus
}
#endif

#endif  // __ALGO_DOUBLE_MATRIX_H__
