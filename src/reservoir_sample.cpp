#include <PSE.h>
#include <assert.h>
#include <random>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <vector>

void reservoir_sample(int *input, int *sample, int n, int k) {
  for (int i = 0; i < k; i++) {
    sample[i] = input[i];
  }
  for (int i = k; i < n; i++) {
    int j;
    auto name = "j_pse_sym_" + std::to_string(0) + std::to_string(i);
    make_pse_symbolic(&j, sizeof(j), name.c_str(), 0, (int)i);
    // klee_print_expr("j_sample \n\t", j);
    if (j <= k) {
      // Forks and produces the tree.
      int pick = rand() % (k - 1);
      sample[pick] = input[i];
    }
  }
}

int main() {
  srand(time(NULL));
  int n = 10;
  int arr[n];
  int k = 6;

  for (size_t i = 0; i < n; i++) {
    arr[i] = i;
  }

  int *sample = (int *)malloc(sizeof(int) * k);
  reservoir_sample(arr, sample, n, k);

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
    // klee_print_expr("Return Value", ret);
    // count here.
  }
  return 0;
}