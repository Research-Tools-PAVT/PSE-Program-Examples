#include <assert.h>
#include <cstdio>
#include <iostream>
#include <random>
#include <vector>

void reservoir_sample(int *input, int *sample, int n, int k) {
  for (int i = 0; i < k; i++) {
    sample[i] = input[i];
  }
  for (int i = k; i < n; i++) {
    // make_pse_symbolic(&j, sizeof(j), "j_sym", 0, (int)i);
    std::default_random_engine generator;
    std::uniform_int_distribution<int> j_dist(0, i);
    int j = j_dist(generator);
    if (j < k) {
      sample[j] = input[i];
    }
  }
}

int main() {
  int termCount = 0, win = 0, loop_count = 0;
  scanf("%d", &termCount);

  while (termCount--) {
    int n = 3;
    int arr[n];

    //  klee_make_symbolic(&k, sizeof(k), "k_sym");
    //  klee_assume(k >= 1 && k <= 3);
    std::default_random_engine generator;
    std::uniform_int_distribution<int> k_dist(1, 3);
    int k = k_dist(generator);

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
      win++;
    }
    loop_count++;
  }

  auto pwin = (double)win / loop_count;
  std::cout << "Prob Assert : " << pwin << "\n";
  return 0;
}