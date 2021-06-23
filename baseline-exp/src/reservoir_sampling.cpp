#include <assert.h>
#include <cstdio>
#include <iostream>
#include <vector>

void reservoir_sample(int *input, int *sample, int n, int k) {
  for (int i = 0; i < k; i++) {
    sample[i] = input[i];
  }
  for (int i = k; i < n; i++) {
    int j;
    // make_pse_symbolic(&j, sizeof(j), "j_sym", 0, (int)i);
    if (j < k) {
      sample[j] = input[i];
    }
  }
}

int main() {
  int n = 3;
  int arr[n];
  int k = 1;
  //  klee_make_symbolic(&k, sizeof(k), "k_sym");
  //  klee_assume(k >= 1 && k <= 3);

  for (size_t i = 0; i < n; i++) {
    arr[i] = i + 1;
  }
  int *sample = (int *)malloc(sizeof(int) * k);
  reservoir_sample(arr, sample, n, k);

  int ret = 0;
  for (int i = 0; i < k; i++) {
    if (arr[0] == sample[i]) {
      ret = 1;
    }
  }
  free(sample);

  if (ret == 1) {
    // klee_dump_kquery_state();
    std::cout << "ret == 1 \n";
  }

  return 0;
}