#include "klee/klee.h"
#include <PSE.h>
#include <string>

#define N 4
int num_comps;

void swap(unsigned char *a, unsigned char *b) {
  unsigned char t = *a;
  *a = *b;
  *b = t;
}

int partition(unsigned char arr[], int low, int high) {
  int pivot_position;
  std::string name = "pivot" + std::to_string(low) + std::to_string(high);
  make_pse_symbolic(&pivot_position, sizeof(pivot_position), name.c_str(),
                    (int)low, (int)high);

  swap(&arr[pivot_position], &arr[high]);
  unsigned char pivot = arr[high];
  int i = (low - 1);
  for (int j = low; j <= high - 1; j++) {
    if (arr[j] <= pivot) {
      num_comps += 1;
      i++;
      swap(&arr[i], &arr[j]);
    }
  }
  swap(&arr[i + 1], &arr[high]);
  return (i + 1);
}

void quicksort(unsigned char arr[], int low, int high) {
  if (low < high) {
    int pi = partition(arr, low, high);
    quicksort(arr, low, pi - 1);
    quicksort(arr, pi + 1, high);
  }
  // num_comps += 1;
}

int main() {
  unsigned char arr[N];
  // klee_make_symbolic(&arr, sizeof(arr), "arr");
  klee_make_symbolic(&num_comps, sizeof(num_comps), "num_comps");

  for (auto i = 0; i < N; i++) {
    unsigned char temp;
    klee_make_symbolic(&temp, sizeof(temp), "arr");
    arr[i] = temp;
  }

  num_comps = 0;
  quicksort(arr, 0, N - 1);

  /* COMMENT : KLEE ASSUMES from ANALYSIS */
  klee_assume(num_comps >= 1 && num_comps <= 5);

  // klee_dump_kquery_state();
  // klee_print_expr("Num Compares : ", num_comps);

  expected_value("num_comps", num_comps);

  // if (num_comps >= 13)
  mark_state_winning();

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
