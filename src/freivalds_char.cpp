/*
 * This is the freivalds_char_first.cpp example.
 */

#include <PSE.h>
#include <stdio.h>
#include <stdlib.h>

void matrix_vector_prod(unsigned char *m, unsigned char *v, size_t n,
                        unsigned char *out) {
  for (size_t i = 0; i < n; i++) {
    unsigned char temp = 0;
    for (size_t j = 0; j < n; j++) {
      temp += m[n * i + j] * v[j];
    }
    out[i] = temp;
  }
}

void vector_subtract(unsigned char *v1, unsigned char *v2, size_t n,
                     unsigned char *out) {
  for (size_t i = 0; i < n; i++) {
    out[i] = v1[i] - v2[i];
  }
}

unsigned char freivalds(unsigned char *A, unsigned char *B, unsigned char *C,
                        unsigned char *r, size_t n) {
  unsigned char *Br = (unsigned char *)malloc(sizeof(unsigned char) * n);
  matrix_vector_prod(B, r, n, Br);

  unsigned char *ABr = (unsigned char *)malloc(sizeof(unsigned char) * n);
  matrix_vector_prod(A, Br, n, ABr);

  unsigned char *Cr = (unsigned char *)malloc(sizeof(unsigned char) * n);
  matrix_vector_prod(C, r, n, Cr);

  unsigned char *res = (unsigned char *)malloc(sizeof(unsigned char) * n);
  vector_subtract(ABr, Cr, n, res);

  unsigned char ret = 1;
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

void matmul(unsigned char *A, unsigned char *B, size_t n, unsigned char *C) {
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
  size_t n = 4;
  unsigned char A[n * n];
  unsigned char B[n * n];
  unsigned char C[n * n];

  for (size_t i = 0; i < n * n; i++) {
    unsigned char tempA, tempB, tempC;
    klee_make_symbolic(&tempA, sizeof(tempA), "A");
    klee_make_symbolic(&tempB, sizeof(tempB), "B");
    klee_make_symbolic(&tempC, sizeof(tempC), "C");
    A[i] = tempA;
    B[i] = tempB;
    C[i] = tempC;
  }

  unsigned char realC[n * n];
  matmul(A, B, n, realC);

  //   klee_assume(C[1] != realC[1]);
  klee_assume(C[0] != realC[0]);

  unsigned char r[n];
  for (size_t i = 0; i < n; i++) {
    unsigned char temp;
    make_pse_symbolic(&temp, sizeof(temp), "r_sym", (unsigned char)0,
                      (unsigned char)1);
    r[i] = temp;
  }

  if (freivalds(A, B, C, r, n) == 1) {
    klee_dump_kquery_state();
  }
  return 0;
}