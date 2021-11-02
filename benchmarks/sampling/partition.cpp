#include <algorithm>
#include <assert.h>
#include <fstream>
#include <functional>
#include <getopt.h> /* getopt */
#include <iomanip>
#include <iostream>
#include <iterator>
#include <json.hpp>
#include <random>
#include <set>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>
unsigned int microseconds = 10000000;

// for convenience
using json = nlohmann::json;
#define SIZE 8

int partition(char arr[]) {
  int pivot_elem, pivot, outcome = 0, left_count = 0, right_count = 0;
  pivot = rand() % (SIZE - 1);
  pivot_elem = arr[pivot];

  // pivot :: prob sym, 0 to SIZE - 1 range
  for (int j = 0; j < SIZE - 1; j++) {
    // COMMENT : Fork Location.
    if (arr[j] < pivot_elem)
      left_count += 1;
    else
      right_count += 1;
  }

  if (left_count < (right_count - 1))
    outcome = (right_count - 1);
  else
    outcome = left_count;

  return outcome;
}

int main() {
  srand(time(NULL));
  int forall_samples = 10;
  while (forall_samples--) {
    char arr[SIZE];
    for (auto i = 0; i < SIZE; i++) {
      arr[i] = rand() % 255;
    }
    int runs = 1000;
    while (runs--) {
      auto outcome = partition(arr);
      printf("Forall : %d, Runs : %d, Num Compares : %d\n", forall_samples,
             runs, outcome);
    }
  }
  return 0;
}
