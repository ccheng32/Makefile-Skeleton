#include "print_hello.h"
#include <omp.h>
#include <stdio.h>

void print_hello() {
#ifdef _OPENMP
#pragma omp parallel
  {
#endif
    printf("Hello from thread %d!\n", omp_get_thread_num());
#ifdef _OPENMP
  }
#endif

  return;
}
