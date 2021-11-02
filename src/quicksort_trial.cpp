// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions
// -emit-llvm -c -o %t1.bc %s RUN: rm -rf %t.klee-out RUN: %klee
// --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests
// --exit-on-error --optimize --disable-inlining --search=nurs:depth
// --use-cex-cache %t1.bc

#include <PSE.h>
#include <assert.h>
#include <random>

/**
 * @brief Initial Specs
 * Create an array of static size, say 5 elements.
 * The elements of the array will be forall symbolic variables.
 * The pivot will be a probabilistic symbolic variable.
 *
 * Must not branch on the SWAP operation after PIVOT selection.
 * Convert to ITEs.
 *
 * analyze the expected number of comparisons in Randomized Quicksort
 * optimize on getting the maximum expected number of comparisons
 * E[count] = n * log(n) for any given random run.
 */

int SIZE = 5;
int count = 0, counter = 0, swap_count = 0;

int partition(int arr[], int left, int right) {
  // pivot element
  int pivot, i = left - 1, random;
  make_pse_symbolic(&random, sizeof(random), "random_sym", (int)left,
                    (int)right);

  pivot = arr[random];
  swap_count += 1;

  for (int j = left; j <= right; j++) {
    /**
     * @brief
     * When we compare with the pivot
     * we need to increase the count so
     * that the expression matches the
     * E[comparisions] for later computation.
     * E[count] ~ n * log(n) ;
     */

    count += 1;

    // COMMENT : Fork Location.
    if (arr[j] <= pivot) {
      swap_count += 1;
      i += 1;
    } else {
      swap_count += 0;
    }
  }

  swap_count += 1;
  return (i + 1);
}

void quicksort_arr(int arr[], int left, int right) {
  /* one path */
  if (left < right) {
    /**
     * @brief Generate a pivot and return the
     * array with pivot placed in the correct position.
     */
    // COMMENT : Symbolic Expression for pivot.
    int pivot = partition(arr, left, right);
    quicksort_arr(arr, left, pivot - 1);
    quicksort_arr(arr, pivot + 1, right);
  }
}

// int concrete[] = {2, 28, 95, 96, 47, 10, 12, 3, 36, 58};

int main() {
  // srand(time(NULL));

  int arr[SIZE];
  klee_make_symbolic(arr, sizeof(arr), "arr_sym");

  // for (auto i = 0; i < SIZE; i++)
  //   arr[i] = concrete[i];

  klee_make_symbolic(&swap_count, sizeof(swap_count), "swap_count_sym");
  swap_count = 0;

  quicksort_arr(arr, 0, SIZE - 1);

  return 0;
}
