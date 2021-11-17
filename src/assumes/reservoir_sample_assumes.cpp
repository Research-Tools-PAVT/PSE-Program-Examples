#include "klee/klee.h"
#include <PSE.h>
#include <assert.h>
#include <random>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string>
#include <time.h>
#include <vector>

void reservoir_sample(int *input, int *sample, int n, int k, int *j_sample) {
  int count = 0;
  for (int i = k; i < n; i++) {
    count++;
    int j;

    std::string name = "jpse_" + std::to_string(count);
    make_pse_symbolic(&j, sizeof(j), name.c_str(), 0, (int)i);

    /* Record the PSE Variables */
    j_sample[i - k] = j;

    // COMMENT : Fork Location.
    if (j < k) {
      // Forks and produces the tree.
      sample[j] = input[i];
    }
  }
}

int main() {
  // srand(time(NULL));
  int n = 13, k = 7;
  int ret = 0;

  /* Hold the record for "j" values sampled */
  int j_sample[n - k];
  int arr[n], sample[k];

  /* Make the forall array symbolic */
  for (int i = 0; i < n; i++) {
    int temp;
    std::string array_symbolic = "arr_" + std::to_string(i);
    klee_make_symbolic(&temp, sizeof(temp), array_symbolic.c_str());
    arr[i] = temp;
  }

  // Distinct Clause
  for (auto i = 1; i < n; ++i) {
    klee_assume(arr[0] != arr[i]);
  }

  for (int i = 0; i < k; i++) {
    sample[i] = arr[i];
  }

  reservoir_sample(arr, sample, n, k, j_sample);

  ret = 0;
  for (int i = 0; i < k; i++) {
    if (arr[0] == sample[i]) {
      ret = 1;
    }
  }

  /* COMMENT : KLEE ASSUMES from ANALYSIS */
  klee_assume(((j_sample[0] > k) && (j_sample[1] > k) && (ret == 1)) ||
              ((j_sample[0] < k) && (j_sample[1] < k) && (ret == 1)) ||
              ((j_sample[0] > k) && (j_sample[1] < k) && (ret == 1)) ||
              ((j_sample[0] < k) && (j_sample[1] < k) && (ret == 1)) ||
              ((j_sample[0] > k) && (j_sample[1] > k) && (ret == 0)));

  if (ret == 1) {
    mark_state_winning();
    klee_dump_kquery_state();
  }

  return 0;
}
