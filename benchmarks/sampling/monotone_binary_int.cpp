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

#define CLASSES 2
#define FORALLS 10
#define RUNS 1000
#define BUCKET_SIZE 5

// Max 23 w/ 10 minute timeout
#define N 4
size_t monotone_check(int *f) {
  int last = f[0];
  size_t count = 0;
  for (size_t i = 1; i < N; i++) {
    if (last > f[i]) {
      count++;
    }
    last = f[i];
  }
  return count;
}

int main() {
  std::freopen("../results/monotone_binary_int.txt", "w", stdout);

  srand(time(NULL));
  std::vector<std::vector<int>> counters(CLASSES,
                                         std::vector<int>(BUCKET_SIZE, 0));
  int forall_classes = CLASSES;
  while (forall_classes--) {
    int forall_samples = FORALLS;
    while (forall_samples--) {
      int runs = RUNS;
      int f[N];

      for (auto i = 0; i < N; i++) {
        f[i] = i + rand() % 51423 - rand() % 14778;
      }
      // TODO : Populate f[], Half array monotonic, quater array monotonic etc.

      // klee_assume(monotone_check(f) == x);
      size_t x = monotone_check(f);
      // klee_make_symbolic(&x, sizeof(x), "x");
      // klee_assume(x >= 0);
      // klee_assume(x < N);

      /* Forall Classes. */
      /* C0 */
      if (forall_classes == 0) {
        f[0] = rand() % 15000;
        f[1] = f[0] + 1 + rand() % 15000;
      }

      /* C1 */
      if (forall_classes == 1) {
        f[0] = rand() % 15000;
        f[1] = f[0] - (1 + rand() % 15000);
      }

      while (runs--) {
        int l = (int)ceil(log2(N - 1));
        int a = 0, i, b = N - 1;
        i = 0 + rand() % (N - 1);

        // make_pse_symbolic(&i, sizeof(i), "i", (int)0, (int)(N - 1));
        bool reject = false;
        for (int t = 0; t < l; t++) {
          int p = (int)ceil((double(a + b)) / (double)2.0);
          /* Fork Location. */
          if (i <= p) {
            if (f[i] > f[p]) {
              reject = true;
            }
            b = p;
          } else {
            if (f[i] < f[p]) {
              reject = true;
            }
            a = p + 1;
          }
        }

        /* PSE Buckets */
        if (i >= N / 4) {
          counters[forall_classes][0] += 1;
        }

        if ((i >= N / 4) && (i <= N / 2)) {
          counters[forall_classes][1] += 1;
        }

        if ((i > N / 2) && (i <= ((3 * N) / 4))) {
          counters[forall_classes][2] += 1;
        }

        if (i >= ((3 * N) / 4)) {
          counters[forall_classes][3] += 1;
        }

        // Query : !reject
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
        std::cout << std::setw(9) << "B" << bucketCounter++;
    flag = 1;
    std::cout << "\n"
              << "C" << classCounter;
    for (const auto &e : x) {
      std::cout << std::setw(9) << e << ", ";
    }
  }

  std::cout << std::endl;

  std::vector<int> valuesMesh;

  for (const auto &x : counters) {
    for (const auto &e : x) {
      valuesMesh.emplace_back(e);
    }
  }

  std::sort(valuesMesh.begin(), valuesMesh.end(), std::greater<int>());
  std::cout << std::endl;

  for (auto x : valuesMesh) {
    std::cout << std::setw(9)
              << (double)((double)x / (FORALLS * RUNS * CLASSES)) << "\n";
  }

  return 0;
}
