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

  void* double_vector_new(size_t);
  size_t double_vector_size(void*);
  double double_vector_get(void*, size_t);
  void double_vector_set(void*, size_t, double);
  int double_vector_equal(void*, void*);
  void double_vector_error(void*, const char*);
  void double_vector_free(void*);

  char* utoa(size_t);

#ifdef __cplusplus
}
#endif

#endif  // __DOUBLE_VECTOR_H__
