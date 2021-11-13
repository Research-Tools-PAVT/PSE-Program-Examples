/*
 * This is the freivalds_int_first.cpp example.
 */

#include <PSE.h>
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string>

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

int main(int argc, char **argv) {
  size_t n = 2;
  int A[n * n];
  int B[n * n];
  int C[n * n];
  int r[n];

  int ret;
  klee_make_symbolic(&ret, sizeof(ret), "ret_sym");

  for (size_t i = 0; i < n * n; i++) {
    int tempA, tempB, tempC;

    std::string a = "A_sym" + std::to_string(i);
    std::string b = "B_sym" + std::to_string(i);
    std::string c = "C_sym" + std::to_string(i);

    klee_make_symbolic(&tempA, sizeof(tempA), a.c_str());
    klee_make_symbolic(&tempB, sizeof(tempB), b.c_str());
    klee_make_symbolic(&tempC, sizeof(tempC), c.c_str());
    A[i] = tempA;
    B[i] = tempB;
    C[i] = tempC;
  }

  int realC[n * n];
  matmul(A, B, n, realC);

  // KLEE optimize wont work since it does compiler optimzation
  // like short-circuit evaluation. Doing so, KLEE may not get
  // some of the KLEE assumes we put in.

  // bool orAssume = false;
  // for (size_t i = 0; i < n * n; i++) {
  //   orAssume = orAssume || (C[i] != realC[i]);
  // }
  // klee_assume(orAssume);

  klee_assume(C[1] != realC[1]);

  for (size_t i = 0; i < n; i++) {
    int temp;
    std::string r_sym = "r_sym_" + std::to_string(i);
    make_pse_symbolic(&temp, sizeof(temp), r_sym.c_str(), (int)0, (int)1);
    r[i] = temp;
  }

  ret = freivalds(A, B, C, r, n);

  if (ret == 1) {
    mark_state_winning();
    klee_dump_kquery_state();
  }

  // expected_value("ret", ret);
  return 0;
}