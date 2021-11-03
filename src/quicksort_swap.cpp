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

void swap(unsigned char *a, unsigned char *b) {
  unsigned char t = *a;
  *a = *b;
  *b = t;
}

int SIZE = 5;
int count = 0, counter = 0, swap_count = 0;

int partition(unsigned char arr[], int left, int right) {
  // pivot element
  int pivot, i = left - 1, random;
  auto pivot_names =
      "random_sym_" + std::to_string(left) + "_" + std::to_string(right);
  make_pse_symbolic(&random, sizeof(random), pivot_names.c_str(), (int)left,
                    (int)right);

  pivot = arr[random];
  swap(&arr[right], &arr[random]);
  swap_count += 1;

  for (int j = left; j <= right - 1; j++) {
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
      swap(&arr[i], &arr[j]);
    } else {
      swap_count += 0;
    }
  }

  swap(&arr[i + 1], &arr[right]);
  swap_count += 1;

  return (i + 1);
}

void quicksort_arr(unsigned char arr[], int left, int right) {
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

  unsigned char arr[SIZE];
  klee_make_symbolic(arr, sizeof(arr), "arr_sym");

  // for (auto i = 0; i < SIZE; i++)
  //   arr[i] = concrete[i];

  klee_make_symbolic(&swap_count, sizeof(swap_count), "swap_count_sym");
  swap_count = 0;

  quicksort_arr(arr, 0, SIZE - 1);

  /* COMMENT : KLEE ASSUMES from ANALYSIS */
  klee_assume((arr[1] > arr[0] && swap_count >= 7) ||
              (arr[1] > arr[0] && swap_count < 9));

  klee_print_expr("Swap (so far) :", swap_count);

  return 0;
}
