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
    // klee_print_expr("i_value\t", i);
    std::string name = "j_pse_" + std::to_string(count) + "_sym";
    make_pse_symbolic(&j, sizeof(j), name.c_str(), 0, (int)i);
    // klee_print_expr("j_sample\t", j);

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
  int n = 8, k;
  int ret = 0;

  klee_make_symbolic(&n, sizeof(n), "n_sym");
  klee_make_symbolic(&k, sizeof(k), "k_sym");

  /* COMMENT : KLEE ASSUMES from ANALYSIS */
  klee_assume((n == 8));
  klee_assume((k >= 2) && k < n);

  /* Hold the record for "j" values sampled */
  int j_sample[n - k];

  int arr[n], sample[k];
  klee_make_symbolic(arr, sizeof(arr), "arr_sym");

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

  // klee_make_symbolic(&ret, sizeof(ret), "ret_sym");
  for (int i = 0; i < k; i++) {
    if (arr[0] == sample[i]) {
      ret = 1;
    }
  }

  klee_print_expr("Return Value", ret);

  /* COMMENT : KLEE ASSUMES from ANALYSIS */
  klee_assume(
      (((k >= n / 2) && (k < (n / 2 + n / 4))) && ret == 0) ||
      ((k >= (n / 2 + n / 4) && (k < (n / 2 + n / 4 + n / 8))) && ret == 0) ||
      ((k >= (n / 2 + n / 4 + n / 8)) && ret == 1) || (k < n / 2));

  if (ret == 1) {
    // klee_assume(ret == 1);
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