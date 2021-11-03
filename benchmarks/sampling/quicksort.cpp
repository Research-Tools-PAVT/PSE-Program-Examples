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

#define CLASSES 4
#define FORALLS 10
#define RUNS 10000
#define BUCKET_SIZE 6
#define N 6

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
  auto name = "random_" + std::to_string(p) + std::to_string(r);
  // printf("%s\n", name.c_str());
  //   make_pse_symbolic(&i, sizeof(i), name.c_str(), (int)p, (int)r);
  int i = p + rand() % (p - r - 1);
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
  std::vector<std::vector<int>> counters(CLASSES,
                                         std::vector<int>(BUCKET_SIZE, 0));
  srand(time(NULL));
  json summaryObj;
  int forall_classes = CLASSES;
  while (forall_classes--) {
    int forall_samples = FORALLS;
    while (forall_samples--) {
      int arr[N] = {0};
      if (forall_classes == 3) {
        arr[0] = rand() % 255;
        arr[1] = arr[0] + 2;
        arr[2] = arr[1] + 2;
      }
      if (forall_classes == 2) {
        arr[0] = rand() % 255;
        arr[1] = arr[0] - 2;
        arr[2] = arr[1] - 2;
      }
      if (forall_classes == 1) {
        arr[0] = rand() % 255;
        arr[1] = arr[0] + 2;
        arr[2] = arr[1] - 2;
      }
      if (forall_classes == 0) {
        arr[0] = rand() % 255;
        arr[1] = arr[0] - 2;
        arr[2] = arr[1] + 2;
      }
      for (auto i = 2; i < N; i++) {
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
        printf("Compares : %d\n", num_comps);
        if (num_comps <= 11) {
          counters[forall_classes][0] += 1;
        }
        if (num_comps == 12) {
          counters[forall_classes][1] += 1;
        }
        if (num_comps == 13) {
          counters[forall_classes][2] += 1;
        }
        if (num_comps == 14) {
          counters[forall_classes][3] += 1;
        }
        if (num_comps == 15) {
          counters[forall_classes][4] += 1;
        }
        if (num_comps >= 16) {
          counters[forall_classes][5] += 1;
        }
      }
    }
    for (auto i = 0; i < BUCKET_SIZE; i++)
      summaryObj["class_" + std::to_string(forall_classes)]
                ["bucket_" + std::to_string(i)] = {
                    "num_comps", counters[forall_classes - 1][i]};
  }
  for (const auto &x : counters) {
    std::cout << std::endl;
    for (const auto &e : x) {
      std::cout << std::setw(7) << e << ",";
    }
  }
  std::cout << std::endl;

  int classCounter = 0;
  int flag = 0;
  for (const auto &x : counters) {
    classCounter++;
    std::cout << std::endl;
    int bucketCounter = 0;
    if (flag == 0)
      for (const auto &e : x)
        std::cout << std::setw(5) << "B" << bucketCounter++;
    flag = 1;
    std::cout << "\n"
              << "C" << classCounter;
    for (const auto &e : x) {
      e >= 17000 ? std::cout << std::setw(5) << 1 << ","
                 : std::cout << std::setw(5) << 0 << ",";
    }
  }
  std::cout << std::endl;
  return 0;
}