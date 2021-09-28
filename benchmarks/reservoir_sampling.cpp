#include <PSE.h>
#include <assert.h>
#include <stdio.h>
#include <vector>

void reservoir_sample(int *input, int *sample, int n, int k) {
  for (int i = 0; i < k; i++) {
    sample[i] = input[i];
  }
  for (int i = k; i < n; i++) {
    int j;
    auto name = "j_sym_" + std::to_string(i);
    make_pse_symbolic(&j, sizeof(j), name.c_str(), 0, (int)i);
    if (j < k) {
      sample[j] = input[i];
    }
  }
}

int main() {
  int n = 10;
  int arr[n];
  int k = 5;

  klee_make_symbolic(arr, sizeof(arr), "forall_array");

  for (size_t i = 0; i < n; i++) {
    arr[i] = i;
  }

  //   for (size_t i = 0; i < n; i++) {
  //     int temp;
  //     auto a_name = "a_sym_" + std::to_string(i);
  //     klee_make_symbolic(&temp, sizeof(temp), a_name.c_str());
  //     arr[i] = temp;
  //   }

  //   for (size_t i = 0; i < n; i++) {
  //     for (size_t j = i + 1; j < n; j++) {
  //       klee_assume(arr[i] != arr[j]);
  //     }
  //   }

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
    klee_dump_kquery_state();
  }
  return 0;
}