// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions
// -emit-llvm -c -o %t1.bc %s RUN: rm -rf %t.klee-out RUN: %klee
// --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests
// --exit-on-error --optimize --disable-inlining --search=nurs:depth
// --use-cex-cache %t1.bc

#include <PSE.h>

#define SIZE 10
int outcome, pivot_elem;

void partition(int arr[]) {

  int pivot, outcome, left_count = 0, right_count = 0;

  klee_make_symbolic(&left_count, sizeof(left_count), "left_count_sym");
  klee_make_symbolic(&right_count, sizeof(right_count), "right_count_sym");
  klee_make_symbolic(&outcome, sizeof(outcome), "outcome_sym");
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
  klee_print_expr("Outcome = ", outcome);
  klee_print_expr("Pivot = ", pivot);
}

// int concrete[] = {2, 28, 95, 96, 47, 454, 65, -56, 7765, 234};

int main() {
  int arr[SIZE];
  // klee_make_symbolic(&SIZE, sizeof(int), "size_array");
  // klee_assume(SIZE == 5);
  klee_make_symbolic(arr, sizeof(arr), "forall_array");
  klee_make_symbolic(&outcome, sizeof(outcome), "outcome_sym");
  klee_make_symbolic(&pivot_elem, sizeof(pivot_elem), "pivot_elem_sym");

  // for (auto i = 0; i < SIZE; i++)
  //   arr[i] = concrete[i];
  partition(arr);

  /* COMMENT : KLEE ASSUMES from ANALYSIS */
  klee_assume((arr[1] > pivot_elem && outcome >= 7) ||
              (arr[1] <= pivot_elem && (outcome < 6)));

  return 0;
}
