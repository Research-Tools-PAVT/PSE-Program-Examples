// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions
// -emit-llvm -c -o %t1.bc %s RUN: rm -rf %t.klee-out RUN: %klee
// --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests
// --exit-on-error --optimize --disable-inlining --search=nurs:depth
// --use-cex-cache %t1.bc

#include "klee/klee.h"
#include <PSE.h>

#define SIZE 7
int outcome, pivot_elem;

int partition(int arr[]) {

  int pivot, left_count = 0, right_count = 0;

  // klee_make_symbolic(&left_count, sizeof(left_count), "left_count_sym");
  // klee_make_symbolic(&right_count, sizeof(right_count), "right_count_sym");
  make_pse_symbolic(&pivot, sizeof(pivot), "pivot_prob_sym", 0, SIZE - 1);

  left_count = 0, right_count = 0;
  pivot_elem = arr[pivot];

  for (int j = 0; j < SIZE - 1; j++) {
    // COMMENT : Fork Location.
    if (arr[j] < pivot_elem)
      left_count += 1;
    else
      right_count += 1;
  }

  if (left_count < (right_count - 1))
    outcome = right_count - 1;
  else
    outcome = left_count;

  /*
   * We want to find the E[max(#left, #right)],
   * #left : count of elements in the left of the pivot.
   * #right : count of elements in the right of the pivot.
   */
  klee_dump_symbolic_details(&outcome, "outcome_sym");
  klee_dump_symbolic_details(&pivot, "pivot_sym");
  // klee_print_expr("Outcome = ", outcome);
  // klee_print_expr("Pivot = ", pivot);

  return outcome;
}

int main() {
  int arr[SIZE];

  klee_make_symbolic(&outcome, sizeof(outcome), "outcome_sym");
  klee_make_symbolic(&pivot_elem, sizeof(pivot_elem), "pivot_elem_sym");

  for (auto i = 0; i < SIZE; i++) {
    int temp;
    std::string array_symbolic = "arr_" + std::to_string(i);
    klee_make_symbolic(&temp, sizeof(temp), array_symbolic.c_str());
    arr[i] = temp;
  }

  outcome = partition(arr);

  /* COMMENT : KLEE ASSUMES from ANALYSIS */
  klee_assume((arr[1] > pivot_elem && outcome >= 3) ||
              (arr[1] <= pivot_elem && (outcome < 5)));

  // Expectation Values.
  expected_value("outcome", outcome);
  mark_state_winning();

  return 0;
}
