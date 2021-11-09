#include "klee/klee.h"
#include <PSE.h>

#define N 5
int num_comps;

void swap(int *a, int *b) {
  int t = *a;
  *a = *b;
  *b = t;
}

int partition(int arr[], int p, int r) {
  int pivot = arr[r];
  int i = p - 1;
  for (int j = p; j <= r - 1; j++) {
    if (arr[j] <= pivot) {
      i++;
      swap(&arr[i], &arr[j]);
    }
    num_comps += 1;
  }
  swap(&arr[i + 1], &arr[r]);
  return i + 1;
}

int randomized_partition(int arr[], int p, int r) {
  int i;
  auto name = "random_" + std::to_string(p) + std::to_string(r);
  make_pse_symbolic(&i, sizeof(i), name.c_str(), (int)p, (int)r);
  swap(&arr[i], &arr[r]);
  return partition(arr, p, r);
}

void quicksort(int arr[], int p, int r) {
  if (p < r) {
    num_comps += 1;
    int q = randomized_partition(arr, p, r);
    quicksort(arr, p, q - 1);
    quicksort(arr, q + 1, r);
  }
}

int main() {
  int arr[N];
  klee_make_symbolic(&arr, sizeof(arr), "arr");
  klee_make_symbolic(&num_comps, sizeof(num_comps), "num_comps");

  num_comps = 0;
  quicksort(arr, 0, N - 1);

  /* COMMENT : KLEE ASSUMES from ANALYSIS */
  klee_assume(num_comps > 10 && num_comps < 13);

  // klee_dump_kquery_state();
  // klee_print_expr("Num Compares : ", num_comps);

  expected_value("num_comps", num_comps);

  if (num_comps > 11) {
    mark_state_winning();
  }

  return 0;
}

/*

KLEE: done: total instructions = 381219
KLEE: done: completed paths = 720
KLEE: done: partially completed paths = 0
KLEE: done: generated tests = 6
Paths Processed : 720

KLEE: done: total instructions = 391441
KLEE: done: completed paths = 296
KLEE: done: partially completed paths = 424
KLEE: done: generated tests = 429
Paths Processed : 720

----------------------------------------------------------------------------------------|
    | B0(<= 11) | B1 ( == 12) | B1 ( == 13) | B1 ( == 14) | B1 ( 15 || 16) | B1
(>= 17) |
----\------------\-------------\------------\-------------\----------------\------------|
C1  |    0       |      0      |     1      |     0       |        0       | 1 |
C2  |    0       |      0      |     1      |     0       |        0       | 1 |
C3  |    0       |      0      |     1      |     0       |        1       | 1 |
C4  |    0       |      0      |     1      |     0       |        0       | 1 |
----------------------------------------------------------------------------------------|

*/