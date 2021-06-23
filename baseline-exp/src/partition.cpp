#include <cstdio>
#include <iostream>

#define SIZE 6

int partition(int arr[], int left, int right) {

  int random, pivot, outcome, left_count, right_count;

  // klee_make_symbolic(&left_count, sizeof(left_count), "left_count_sym");
  // klee_make_symbolic(&right_count, sizeof(right_count), "right_count_sym");
  // klee_make_symbolic(&outcome, sizeof(outcome), "outcome_sym");
  // klee_make_symbolic(&pivot, sizeof(pivot), "pivot_prob_sym");

  left_count = 0;
  right_count = 0;

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

  return outcome;
}

int main() {
  int arr[SIZE];
  // klee_make_symbolic(arr, sizeof(arr), "forall_array");

  // for (auto i = 0; i < SIZE; i++)
  //   arr[i] = concrete[i];

  partition(arr, 0, SIZE - 1);

  return 0;
}