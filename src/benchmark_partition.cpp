// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions
// -emit-llvm -c -o %t1.bc %s RUN: rm -rf %t.klee-out RUN: %klee
// --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests
// --exit-on-error --optimize --disable-inlining --search=nurs:depth
// --use-cex-cache %t1.bc

#include "PSE.h"
#include <assert.h>
#include <random>

// #define SIZE 4
int SIZE;

int partition(int arr[], int left, int right) {
  srand(time(NULL));

  int random, pivot, outcome, left_count = 0, right_count = 0;

  klee_make_symbolic(&left_count, sizeof(left_count), "left_count_sym");
  klee_make_symbolic(&right_count, sizeof(right_count), "right_count_sym");
  klee_make_symbolic(&outcome, sizeof(outcome), "outcome_sym");
  klee_make_symbolic(&pivot, sizeof(pivot), "pivot_prob_sym");

  // pivot element
  random = left + rand() % abs(right - left);
  pivot = arr[random];

  for (int j = left; j <= right; j++) {
    // COMMENT : Fork Location.
    arr[j] < pivot ? left_count++ : right_count++;
  }

  outcome = left_count < (right_count - 1) ? (right_count - 1) : left_count;

  klee_dump_symbolic_details(&outcome, "outcome_sym");

  return outcome;
}

int concrete[] = {2, 28, 95, 96, 47, 10, 12, 3, 36, 58};

int main() {
  int arr[SIZE];
  klee_make_symbolic(&SIZE, sizeof(int), "size_array");
  klee_assume(SIZE > 10 && SIZE <= 50);
  klee_make_symbolic(arr, sizeof(arr), "forall_array");

  // for (auto i = 0; i < SIZE; i++)
  //   arr[i] = concrete[i];

  partition(arr, 0, SIZE - 1);

  return 0;
}
