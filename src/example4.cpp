// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions
// -emit-llvm -c -o %t1.bc %s RUN: rm -rf %t.klee-out RUN: %klee
// --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests
// --exit-on-error --optimize --disable-inlining --search=nurs:depth
// --use-cex-cache %t1.bc

#include "PSE.h"
#include <assert.h>
#include <stdio.h>
#include <vector>

void reservoir_sample(int *input, int *sample, int n, int k) {
  for (int i = 0; i < k; i++) {
    sample[i] = input[i];
  }
  for (int i = k; i < n; i++) {
    int j;
    make_pse_symbolic(&j, sizeof(j), "j_sym", 0, (int)i);
    if (j < k) {
      sample[j] = input[i];
    }
  }
}

int main() {
  int n = 3;
  int arr[n];
  int k;
  klee_make_symbolic(&k, sizeof(k), "k_sym");
  klee_assume(k >= 1 && k <= 3);

  for (size_t i = 0; i < n; i++) {
    arr[i] = i + 1;
  }
  int *sample = (int *)malloc(sizeof(int) * k);
  reservoir_sample(arr, sample, n, k);

  for (int i = 0; i < k; i++) {
    if (arr[0] == sample[i]) {
      free(sample);
      return 1;
    }
  }
  free(sample);
  return 0;
}
