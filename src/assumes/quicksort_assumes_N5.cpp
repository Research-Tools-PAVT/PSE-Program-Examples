#include "klee/klee.h"
#include <PSE.h>
#include <string>

#define N 5
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
      i++;
      swap(&arr[i], &arr[j]);
      num_comps += 1;
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
  klee_assume(num_comps == 3 || num_comps == 6 || num_comps == 7 ||
              num_comps == 4 || num_comps == 8);

  // klee_dump_kquery_state();
  // klee_print_expr("Num Compares : ", num_comps);

  expected_value("num_comps", num_comps);

  // if (num_comps >= 13)
  mark_state_winning();

  return 0;
}
