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

#define CLASSES 20
#define FORALLS 100
#define RUNS 10000

#define N 10

int num_comps;

void swap(unsigned char *a, unsigned char *b) {
  unsigned char t = *a;
  *a = *b;
  *b = t;
}

int partition(unsigned char arr[], int p, int r) {
  unsigned char pivot = arr[r];
  int i = (p - 1);

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

int randomized_partition(unsigned char arr[], int p, int r) {
  auto name = "i_" + std::to_string(p) + std::to_string(r);
  // printf("%s\n", name.c_str());
  //   make_pse_symbolic(&i, sizeof(i), name.c_str(), (int)p, (int)r);
  int i = rand() % (p - r - 1) + p;
  swap(&arr[i], &arr[r]);
  return partition(arr, p, r);
}

void quicksort(unsigned char arr[], int p, int r) {
  if (p < r) {
    num_comps += 1;
    int q = randomized_partition(arr, p, r);
    quicksort(arr, p, q - 1);
    quicksort(arr, q + 1, r);
  }
}

int main() {
  srand(time(NULL));
  int forall_classes = CLASSES;
  while (forall_classes--) {
    int forall_samples = FORALLS;
    while (forall_samples--) {
      unsigned char arr[N];
      for (auto i = 0; i < N; i++) {
        arr[i] = rand() % 255;
      }
      //   klee_make_symbolic(&arr, sizeof(arr), "arr");
      //   klee_make_symbolic(&num_comps, sizeof(num_comps), "num_comps");
      int runs = RUNS;
      while (runs--) {
        num_comps = 0;
        quicksort(arr, 0, N - 1);
        //   klee_dump_kquery_state();
        //   klee_print_expr("Num Compares : ", num_comps);
        //   klee_dump_symbolic_details(&num_comps, "num_comps");
        printf("Class : %d, Forall : %d, Runs : %d, Num Compares : %d\n",
               forall_classes, forall_samples, runs, num_comps);
      }
    }
  }
  return 0;
}