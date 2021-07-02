#include <cstdio>
#include <init.h>
#include <iostream>
#include <random>
#include <string>
#include <unordered_map>
#include <vector>

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

int freivalds(unsigned char *A, unsigned char *B, unsigned char *C,
              unsigned char *r, size_t n) {
  unsigned char *Br = (unsigned char *)malloc(sizeof(unsigned char) * n);
  matrix_vector_prod(B, r, n, Br);

  unsigned char *ABr = (unsigned char *)malloc(sizeof(unsigned char) * n);
  matrix_vector_prod(A, Br, n, ABr);

  unsigned char *Cr = (unsigned char *)malloc(sizeof(unsigned char) * n);
  matrix_vector_prod(C, r, n, Cr);

  unsigned char *res = (unsigned char *)malloc(sizeof(unsigned char) * n);
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
  int termCount = 0, win = 0, loop_count = 0;
  scanf("%d", &termCount);

  while (termCount--) {
    size_t n = 3;
    unsigned char A[n * n];
    unsigned char B[n * n];
    unsigned char C[n * n];

    std::default_random_engine generator;
    std::uniform_int_distribution<int> int_dist(0, 255);
    // klee_make_symbolic(&A, sizeof(int)*n*n, "A");
    // klee_make_symbolic(&B, sizeof(int)*n*n, "B");
    // klee_make_symbolic(&C, sizeof(int)*n*n, "C");

    for (size_t i = 0; i < n * n; i++) {
      unsigned char tempA = int_dist(generator), tempB = int_dist(generator),
                    tempC = int_dist(generator);
      // klee_make_symbolic(&tempA, sizeof(tempA), "A");
      // klee_make_symbolic(&tempB, sizeof(tempB), "B");
      // klee_make_symbolic(&tempC, sizeof(tempC), "C");
      A[i] = tempA;
      B[i] = tempB;
      C[i] = tempC;
    }

    unsigned char realC[n * n];
    matmul(A, B, n, realC);

    // realC[] & C[] must not be
    // identiaclly same.
    bool orAssume = false;
    for (size_t i = 0; i < n * n; i++) {
      orAssume = orAssume || (C[i] != realC[i]);
    }

    // This is a condition that must hold.
    // Need to check which ones hold.
    // klee_assume(orAssume);
    // klee_assume(C[0] != realC[0]);

    unsigned char r[n];
    for (size_t i = 0; i < n; i++) {
      unsigned char temp = int_dist(generator) > 128 ? 0 : 1;
      // make_pse_symbolic(&temp, sizeof(temp), "r_sym", (unsigned char)0,
      //                   (unsigned char)1);
      r[i] = temp;
    }

    if (freivalds(A, B, C, r, n) == 1) {
      // klee_dump_kquery_state();
      std::cout << "Win!\n";
      win++;
    }
    loop_count++;
  }

  auto pwin = (double)win / loop_count;
  std::cout << "Prob Assert : " << pwin << "\n";
  return 0;
}
