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
  for (int i = 0; i < k; i++) {
    sample[i] = input[i];
  }

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

  // for (std::size_t i = 0; i < n - k; i++)
  //   klee_print_expr("j_sample \t", j_sample[i]);
}

int main() {
  // srand(time(NULL));
  int n, k;

  klee_make_symbolic(&n, sizeof(n), "n_sym");
  klee_make_symbolic(&k, sizeof(k), "k_sym");

  /* COMMENT : KLEE ASSUMES from ANALYSIS */
  klee_assume(k == 11 && n == 20);

  /* Hold the record for "j" values sampled */
  int j_sample[n - k];

  int arr[n];
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

  int *sample = (int *)malloc(sizeof(int) * k);
  reservoir_sample(arr, sample, n, k, j_sample);

  int ret = 0;
  // klee_make_symbolic(&ret, sizeof(ret), "ret_sym");
  for (int i = 0; i < k; i++) {
    if (arr[0] == sample[i]) {
      ret = 1;
    }
  }

  free(sample);

  if (ret == 1) {
    // klee_assume(ret == 1);
    klee_dump_kquery_state();
    klee_print_expr("Return Value", ret);
    // count here.
  }

  /* COMMENT : KLEE ASSUMES from ANALYSIS */
  klee_assume((k > j_sample[0] && k > j_sample[1] && ret == 1) ||
              (k < j_sample[0] && k < j_sample[1] && ret == 0));

  return 0;
}