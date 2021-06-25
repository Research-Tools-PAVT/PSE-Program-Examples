#include <cstdio>
#include <iostream>
#include <random>

#define SIZE 6

int partition(unsigned int arr[], int left, int right) {

  int random, pivot, outcome, left_count, right_count;
  std::default_random_engine generator;
  std::uniform_int_distribution<int> range_dist(left, right);
  // klee_make_symbolic(&left_count, sizeof(left_count), "left_count_sym");
  // klee_make_symbolic(&right_count, sizeof(right_count), "right_count_sym");
  // klee_make_symbolic(&outcome, sizeof(outcome), "outcome_sym");
  // klee_make_symbolic(&pivot, sizeof(pivot), "pivot_prob_sym");

  left_count = 0;
  right_count = 0;
  random = range_dist(generator);
  // pivot element
  // make_pse_symbolic(&random, sizeof(random), "random", (int)left,
  // (int)right);
  pivot = arr[random];

  for (int j = left; j <= right; j++) {
    // COMMENT : Fork Location.
    if (arr[j] < pivot) {
      left_count++;
    } else {
      right_count++;
    }
  }

  outcome = left_count < (right_count - 1) ? (right_count - 1) : left_count;

  // klee_dump_kquery_state();
  // klee_dump_symbolic_details(&outcome, "outcome_sym");
  std::cout << "Outcome : " << outcome << "\n";
  return outcome;
}

int main() {
  int termCount = 0, win = 0, loop_count = 0;
  scanf("%d", &termCount);

  while (termCount--) {
    unsigned int arr[SIZE];
    std::default_random_engine generator;
    std::uniform_int_distribution<int> value_dist(0, INT32_MAX);
    // klee_make_symbolic(arr, sizeof(arr), "forall_array");

    for (auto i = 0; i < SIZE; i++)
      arr[i] = value_dist(generator);

    partition(arr, 0, SIZE - 1);
    loop_count++;
  }

  auto pwin = (double)win / loop_count;
  std::cout << "Prob Assert : " << pwin << "\n";
  return 0;
}