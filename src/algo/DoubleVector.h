#ifndef __ALGO_DOUBLE_VECTOR_H__
#define __ALGO_DOUBLE_VECTOR_H__

#ifdef __cplusplus
#include <cstddef>
#else
#include <stddef.h>
#endif

#ifdef __cplusplus
extern "C" {
#endif

  typedef struct DoubleVector {
    size_t size;
    double* vec;
  } DoubleVector;

  DoubleVector* algo_double_vector_new(size_t);
  size_t algo_double_vector_size(DoubleVector*);
  double algo_double_vector_get(DoubleVector*, size_t);
  void algo_double_vector_set(DoubleVector*, size_t, double);
  double algo_double_vector_magnitude(DoubleVector*);
  int algo_double_vector_equal(DoubleVector*, DoubleVector*);
  DoubleVector* algo_double_vector_add(DoubleVector*, DoubleVector*);
  DoubleVector* algo_double_vector_scalar_add(DoubleVector*, double);
  DoubleVector* algo_double_vector_sub(DoubleVector*, DoubleVector*);
  DoubleVector* algo_double_vector_scalar_sub_first(double, DoubleVector*);
  DoubleVector* algo_double_vector_scalar_sub_second(DoubleVector*, double);
  DoubleVector* algo_double_vector_mul(DoubleVector*, DoubleVector*);
  DoubleVector* algo_double_vector_scalar_mul(DoubleVector*, double);
  DoubleVector* algo_double_vector_div(DoubleVector*, DoubleVector*);
  DoubleVector* algo_double_vector_scalar_div_first(double, DoubleVector*);
  DoubleVector* algo_double_vector_scalar_div_second(DoubleVector*, double);
  DoubleVector* algo_double_vector_pow(DoubleVector*, DoubleVector*);
  DoubleVector* algo_double_vector_scalar_pow_first(double, DoubleVector*);
  DoubleVector* algo_double_vector_scalar_pow_second(DoubleVector*, double);
  double algo_double_vector_dot(DoubleVector*, DoubleVector*);
  void algo_double_vector_error(DoubleVector*, const char*);
  void algo_double_vector_free(DoubleVector*);

  char* utoa(size_t);

#ifdef __cplusplus
}
#endif

#endif  // __ALGO_DOUBLE_VECTOR_H__
