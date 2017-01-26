#ifndef __DOUBLE_VECTOR_H__
#define __DOUBLE_VECTOR_H__

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

  DoubleVector* double_vector_new(size_t);
  size_t double_vector_size(DoubleVector*);
  double double_vector_get(DoubleVector*, size_t);
  void double_vector_set(DoubleVector*, size_t, double);
  int double_vector_equal(DoubleVector*, DoubleVector*);
  DoubleVector* double_vector_add(DoubleVector*, DoubleVector*);
  DoubleVector* double_vector_scalar_add(DoubleVector*, double);
  void double_vector_error(DoubleVector*, const char*);
  void double_vector_free(DoubleVector*);

  char* utoa(size_t);

#ifdef __cplusplus
}
#endif

#endif  // __DOUBLE_VECTOR_H__
