#include <algorithm>
#include <assert.h>
#include <fstream>
#include <functional>
#include <getopt.h> /* getopt */
#include <iomanip>
#include <iostream>
#include <iterator>
#include <json.hpp>
#include <random>
#include <set>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>
unsigned int microseconds = 10000000;

// for convenience
using json = nlohmann::json;

#define CLASSES 4
#define FORALLS 10
#define RUNS 10000
#define BUCKET_SIZE 9

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
  std::freopen("../results/freivalds_int.txt", "w", stdout);
  std::set<int> pseDistinct, forallDistinct;
  srand(time(NULL));
  std::vector<std::vector<int>> counters(CLASSES,
                                         std::vector<int>(BUCKET_SIZE, 0));
  int forall_classes = CLASSES;
  while (forall_classes--) {
    int forall_samples = FORALLS;
    while (forall_samples--) {
      int runs = RUNS;
      size_t n = 3;
      int A[n * n];
      int B[n * n];
      int C[n * n];

      for (size_t i = 0; i < n * n; i++) {
        A[i] = rand() % 5000;
        B[i] = rand() % 5000;
        C[i] = rand() % 5000;
      }

      int realC[n * n];
      matmul(A, B, n, realC);

      // klee_assume(C[0] != realC[0]);
      if (rand() % 5000 == 0)
        C[0] = realC[0] + 1 + rand() % 10;
      else
        C[0] = realC[0] - 1 - rand() % 10;

      /* C3 */
      if (forall_classes == 3) {
        C[1] = realC[1];
        C[2] = realC[2];
      }

      /* C2 */
      if (forall_classes == 2) {
        if (rand() % 5000 == 0)
          C[1] = realC[1] + 1 + rand() % 10;
        else
          C[1] = realC[1] - 1 - rand() % 10;
        C[2] = realC[2];
      }

      /* C1 */
      if (forall_classes == 1) {
        if (rand() % 5000 == 0)
          C[2] = realC[2] + 1 + rand() % 10;
        else
          C[2] = realC[2] - 1 - rand() % 10;
        C[1] = realC[1];
      }

      /* C0 */
      if (forall_classes == 0) {
        if (rand() % 5000 == 0)
          C[1] = realC[1] + 1 + rand() % 10;
        else
          C[1] = realC[1] - 1 - rand() % 10;

        if (rand() % 5000 == 0)
          C[2] = realC[2] + 1 + rand() % 10;
        else
          C[2] = realC[2] - 1 - rand() % 10;
      }

      while (runs--) {
        int ret = 0;
        int r[n];
        int bucketChoosen = 0;
        for (size_t i = 0; i < n; i++) {
          r[i] = (rand() % 50000) % 2;
        }

        ret = freivalds(A, B, C, r, n);

        if (r[0] != 1 && r[1] == 1 && r[2] == 1 && ret == 1) {
          bucketChoosen = 0;
          counters[forall_classes][0] += 1;
        }

        if (r[0] != 1 && r[1] == 1 && r[2] != 1 && ret == 1) {
          bucketChoosen = 1;
          counters[forall_classes][1] += 1;
        }

        if (r[0] == 1 && r[1] != 1 && r[2] == 1 && ret == 1) {
          bucketChoosen = 2;
          counters[forall_classes][2] += 1;
        }

        if (r[0] == 1 && r[1] != 1 && r[2] != 1 && ret == 1) {
          bucketChoosen = 3;
          counters[forall_classes][3] += 1;
        }

        if (r[0] != 1 && r[1] != 1 && r[2] == 1 && ret == 1) {
          bucketChoosen = 4;
          counters[forall_classes][4] += 1;
        }

        if (r[0] != 1 && r[1] != 1 && r[2] != 1 && ret == 1) {
          bucketChoosen = 5;
          counters[forall_classes][5] += 1;
        }

        if (r[0] == 1 && r[1] == 1 && r[2] == 1 && ret == 1) {
          bucketChoosen = 6;
          counters[forall_classes][6] += 1;
        }

        if (r[0] == 1 && r[1] == 1 && r[2] != 1 && ret == 1) {
          bucketChoosen = 7;
          counters[forall_classes][7] += 1;
        }

        /* Non Winning Case here. */
        if (ret == 0) {
          bucketChoosen = 8;
          counters[forall_classes][8] += 1;
        }
      }
    }
  }

  // for (const auto &x : counters) {
  //   std::cout << std::endl;
  //   for (const auto &e : x) {
  //     std::cout << std::setw(7) << e << ",";
  //   }
  // }
  // std::cout << std::endl;

  int classCounter = 0;
  int flag = 0;
  for (const auto &x : counters) {
    classCounter++;
    std::cout << std::endl;
    int bucketCounter = 0;
    if (flag == 0)
      for (const auto &e : x)
        std::cout << std::setw(8) << "B" << bucketCounter++;
    flag = 1;
    std::cout << "\n"
              << "C" << classCounter;
    for (const auto &e : x) {
      std::cout << std::setw(7) << e << ", ";
    }
  }

  std::cout << std::endl;

  return 0;
}