#include <assert.h>
#include <cstdio>
#include <iostream>
#include <vector>

void fisher_yates_sample(int *input, int *sample, int n, int k) {
  int x[n];
  for (int i = 0; i < n; i++) {
    x[i] = input[i];
  }

  for (int i = 0; i < k; i++) {
    int r;
    int upper_bound = n - i;
    // make_pse_symbolic(&r, sizeof(r), "r_sym", 0, (int)upper_bound);

    int temp = x[n - i];
    x[n - i] = x[r];
    x[r] = temp;
  }
  for (int i = n - k; i < n; i++) {
    sample[i - (n - k)] = x[i];
  }
}

int main() {
  int n = 3;
  int arr[n];
  int k;
  //   klee_make_symbolic(&k, sizeof(k), "k_sym");
  //   klee_assume(k >= 1 && k <= 2);

  for (size_t i = 0; i < n; i++) {
    int temp;
    // klee_make_symbolic(&temp, sizeof(temp), "a");
    arr[i] = temp;
  }
  // Assume distinct inputs
  for (size_t i = 0; i < n; i++) {
    for (size_t j = i + 1; j < n; j++) {
      //   klee_assume(arr[i] != arr[j]);
    }
  }

  int *sample = (int *)malloc(sizeof(int) * k);
  fisher_yates_sample(arr, sample, n, k);

  int ret = 0;
  for (int i = 0; i < k; i++) {
    if (arr[0] == sample[i]) {
      ret = 1;
    }
  }
  free(sample);

  if (ret == 1) {
    // klee_dump_kquery_state();
    std::cout << "ret == 1\n";
  }
  return 0;
}