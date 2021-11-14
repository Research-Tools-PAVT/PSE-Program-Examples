/*
 * This is the freivalds_int_first.cpp example.
 */

#include <PSE.h>
#include <stdio.h>
#include <stdlib.h>
void matrix_vector_prod(int *m, int *v, size_t n, int *out) {
  for (size_t i = 0; i < n; i++) {
    int temp = 0;
    for (size_t j = 0; j < n; j++) {
      temp += m[n * i + j] * v[j];
    }
    out[i] = temp;
  }
}

void vector_subtract(int *v1, int *v2, size_t n, int *out) {
  for (size_t i = 0; i < n; i++) {
    out[i] = v1[i] - v2[i];
  }
}

int freivalds(int *A, int *B, int *C, int *r, size_t n) {
  int *Br = (int *)malloc(sizeof(int) * n);
  matrix_vector_prod(B, r, n, Br);

  int *ABr = (int *)malloc(sizeof(int) * n);
  matrix_vector_prod(A, Br, n, ABr);

  int *Cr = (int *)malloc(sizeof(int) * n);
  matrix_vector_prod(C, r, n, Cr);

  int *res = (int *)malloc(sizeof(int) * n);
  vector_subtract(ABr, Cr, n, res);

  int ret = 1;
  for (size_t i = 0; i < n; i++) {
    if (res[i] != 0) {
      ret = 0;
    }
  }

  free(Br);
  free(ABr);
  free(Cr);
  free(res);
  return ret;
}

void matmul(int *A, int *B, size_t n, int *C) {
  for (size_t i = 0; i < n; i++) {
    for (size_t j = 0; j < n; j++) {
      C[i * n + j] = 0;
      for (size_t k = 0; k < n; k++) {
        C[i * n + j] += A[i * n + k] * B[k * n + j];
      }
    }
  }
}

int main() {
  size_t n = 3;
  int A[n * n];
  int B[n * n];
  int C[n * n];

  for (size_t i = 0; i < n * n; i++) {
    int tempA, tempB, tempC;
    klee_make_symbolic(&tempA, sizeof(tempA), "A");
    klee_make_symbolic(&tempB, sizeof(tempB), "B");
    klee_make_symbolic(&tempC, sizeof(tempC), "C");
    A[i] = tempA;
    B[i] = tempB;
    C[i] = tempC;
  }

  int realC[n * n];
  matmul(A, B, n, realC);

  bool orAssume = false;
  for (size_t i = 0; i < n * n; i++) {
    orAssume = orAssume || (C[i] != realC[i]);
  }

  klee_assume(orAssume);
  // klee_assume(C[0] != realC[0]);

  int r[n];
  for (size_t i = 0; i < n; i++) {
    int temp;
    make_pse_symbolic(&temp, sizeof(temp), "r_sym", (int)0, (int)1);
    r[i] = temp;
  }

  if (freivalds(A, B, C, r, n) == 1) {
    mark_state_winning();
    klee_dump_kquery_state();
  }

  return 0;
}