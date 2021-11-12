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
  int n = 15, k = 6;
  int ret = 0;

  // klee_make_symbolic(&n, sizeof(n), "n_sym");
  // klee_make_symbolic(&k, sizeof(k), "k_sym");

  /* COMMENT : KLEE ASSUMES from ANALYSIS */
  // klee_assume((n == 10) && (k == 4));
  // klee_assume((k >= 3) && k < n);

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

  // for (size_t i = 0; i < n; i++) {
  //   arr[i] = i;
  // }

  // Distinct Clause
  for (auto i = 0; i < n; ++i) {
    for (auto j = 0; j < n; ++j) {
      if (j > i)
        klee_assume(arr[j] != arr[i]);
    }
  }

  for (int i = 0; i < k; i++) {
    sample[i] = arr[i];
  }

  reservoir_sample(arr, sample, n, k, j_sample);
  klee_make_symbolic(&ret, sizeof(ret), "ret_sym");

  ret = 0;
  for (int i = 0; i < k; i++) {
    if (arr[0] == sample[i]) {
      ret = 1;
    }
  }

  // klee_print_expr("Return Value", ret);

  /* COMMENT : KLEE ASSUMES from ANALYSIS */
  klee_assume(((j_sample[0] > k) && (j_sample[1] > k) && (ret == 1)) ||
              ((j_sample[0] < k) && (j_sample[1] < k) && (ret == 1)) ||
              ((j_sample[0] > k) && (j_sample[1] < k) && (ret == 1)) ||
              ((j_sample[0] < k) && (j_sample[1] < k) && (ret == 1)));

  // Capture the value of ret.
  expected_value("ret", ret);

  if (ret == 1) {
    // klee_assume(ret == 1);
    mark_state_winning();
    klee_dump_kquery_state();
  }

  return 0;
}

/*
  ```
  Without Assumes :

  KLEE: done: total instructions = 26934
  KLEE: done: completed paths = 127
  KLEE: done: partially completed paths = 1
  KLEE: done: generated tests = 5
  Paths Processed : 127
  ```

  ```
  With Assumes :

  KLEE: done: total instructions = 31184
  KLEE: done: completed paths = 63
  KLEE: done: partially completed paths = 65
  KLEE: done: generated tests = 66
  Paths Processed : 127
  ```
-------------------------------
    | B0(ret==0) | B1 (ret==1) |
----\------------\-------------\
C1  |    1       |      1      |
C2  |    0       |      1      |
C3  |    0       |      1      |
C4  |    1       |      0      |
C5  |    1       |      1      |
-------------------------------|
*/