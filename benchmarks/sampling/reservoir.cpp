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

#ifndef MIN_RANGE
#define MIN_RANGE -2147483646
#endif

#ifndef MAX_RANGE
#define MAX_RANGE 2147483646
#endif

#define CLASSES 5
#define FORALLS 10
#define RUNS 1000

int reservoir_sample(int *input, int *sample, int n, int k) {
  int count = 0;
  for (int i = 0; i < k; i++) {
    sample[i] = input[i];
  }

  for (int i = k; i < n; i++) {
    int j = rand() % (i - 1);
    // make_pse_symbolic(&j, sizeof(j), name.c_str(), 0, (int)i);
    // COMMENT : Fork Location.
    if (j < k) {
      // Forks and produces the tree.
      count++;
      sample[j] = input[i];
    }
  }
  return count;
}

int main() {
  srand(time(NULL));
  int forall_classes = CLASSES;
  while (forall_classes--) {
    int forall_samples = FORALLS;
    while (forall_samples--) {
      int n = rand() % 100, k = rand() % 100;
      //   klee_make_symbolic(&n, sizeof(n), "n_sym");
      //   klee_make_symbolic(&k, sizeof(k), "k_sym");
      //   klee_assume(k == 6 && n == 10);
      int arr[n];
      //   klee_make_symbolic(arr, sizeof(arr), "arr_sym");

      for (size_t i = 0; i < n; i++) {
        arr[i] = rand() % 14241 + rand() % 62354 + rand() % 5412 + rand();
      }

      int *sample = (int *)malloc(sizeof(int) * k);
      int runs = RUNS;
      while (runs--) {
        reservoir_sample(arr, sample, n, k);
        int ret = 0;
        // klee_make_symbolic(&ret, sizeof(ret), "ret_sym");
        for (int i = 0; i < k; i++) {
          if (arr[0] == sample[i]) {
            ret = 1;
            break;
          }
        }
        printf("Class : %d, Forall : %d, Runs : %d, Num Compares : %d\n",
               forall_classes, forall_samples, runs, ret);
      }
      free(sample);
    }
  }

  return 0;
}