#ifndef __DOUBLE_MATRIX_H__
#define __DOUBLE_MATRIX_H__

#ifdef __cplusplus
#include <cstddef>
#else
#include <stddef.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

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

#ifdef __cplusplus
}
#endif

#endif  // __DOUBLE_MATRIX_H__
