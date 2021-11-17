#include <algorithm>
#include <assert.h>
#include <cstdio>
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

// for convenience
using json = nlohmann::json;

#define CLASSES 5
#define FORALLS 10
#define RUNS 100000
#define BUCKET_SIZE 5
#define N 5

int num_comps = 0;

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
      num_comps += 1;
    }
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
    int q = randomized_partition(arr, p, r);
    quicksort(arr, p, q - 1);
    quicksort(arr, q + 1, r);
  }
  // num_comps += 1;
}

int main() {

  std::freopen("../results/quicksort_N5.txt", "w", stdout);

  srand(time(NULL));
  std::vector<std::vector<int>> counters(CLASSES,
                                         std::vector<int>(BUCKET_SIZE, 0));
  json summaryObj;
  int forall_classes = CLASSES;
  while (forall_classes--) {
    std::cout << "forall_classes = " << forall_classes << std::endl;
    int forall_samples = FORALLS;
    int runsCC = 0;

    // counters[forall_classes][0] = 0;
    // counters[forall_classes][1] = 0;
    // counters[forall_classes][2] = 0;
    // counters[forall_classes][3] = 0;
    // counters[forall_classes][4] = 0;
    // counters[forall_classes][5] = 0;
    // counters[forall_classes][6] = 0;

    while (forall_samples--) {
      std::unordered_map<int, int> forallSamplesDist;
      for (int i = 0; i < BUCKET_SIZE; i++)
        forallSamplesDist[i] = 0;

      int arr[N] = {0};
      if (forall_classes == 3) {
        arr[0] = rand() % 65536;
        arr[1] = arr[0] + 1 + rand() % 65536;
        arr[2] = arr[1] + 1 + rand() % 65536;
      } else if (forall_classes == 2) {
        arr[0] = rand() % 65536;
        arr[1] = arr[0] - (1 + rand() % 65536);
        arr[2] = arr[1] - (1 + rand() % 65536);
      } else if (forall_classes == 1) {
        arr[0] = rand() % 65536;
        arr[1] = arr[0] + 1 + rand() % 65536;
        arr[2] = arr[1] - (1 + rand() % 65536);
      } else if (forall_classes == 0) {
        arr[0] = rand() % 65536;
        arr[1] = arr[0] - (1 + rand() % 65536);
        arr[2] = arr[1] + 1 + rand() % 65536;
      } else {
        arr[0] = rand() % 65536;
        arr[1] = arr[0];
        arr[2] = arr[0];
      }

      for (auto i = 3; i < N; i++) {
        arr[i] = rand() % 65536;
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
        // printf("Compares : %d\n", num_comps);

        /* PSE Buckets */
        if (num_comps <= 2) {
          forallSamplesDist[0] += 1;
        }
        if (num_comps == 3 || num_comps == 4) {
          forallSamplesDist[1] += 1;
        }
        if (num_comps == 5 || num_comps == 6 || num_comps == 7) {
          forallSamplesDist[2] += 1;
        }
        if (num_comps == 8) {
          forallSamplesDist[3] += 1;
        }
        if (num_comps >= 9) {
          forallSamplesDist[4] += 1;
        }
      }

      for (const auto &e : forallSamplesDist) {
        if ((e.second) >= counters[forall_classes][e.first]) {
          counters[forall_classes][e.first] = (e.second);
        }
      }
    }
  }

  // for (const auto &x : counters) {
  //   std::cout << std::endl;
  //   for (const auto &e : x) {
  //     std::cout << std::setw(7) << e << ",";
  //   }
  // }

  // std::cout << std::endl;

  /* Print the frequency Table */
  int classCounter = 0;
  int flag = 0;
  for (const auto &x : counters) {
    // std::cout << std::endl;
    int bucketCounter = 0;

    if (flag == 0) {
      for (const auto &e : x)
        std::cout << std::setw(10) << "B" << bucketCounter++;
    }

    flag = 1;
    std::cout << "\n"
              << "C" << classCounter;
    int bucket = 0;
    double total = 0;
    for (const auto &e : x) {
      // e >= 17000 ? std::cout << std::setw(5) << 1 << ","
      //            : std::cout << std::setw(5) << 0 << ",";
      std::cout << std::setw(9) << e << ", ";
    }
    classCounter++;
  }

  std::cout << std::endl << std::endl;

  // /* Print the frequency Table */
  classCounter = 0;
  flag = 0;
  for (const auto &x : counters) {
    // std::cout << std::endl;
    int bucketCounter = 0;

    if (flag == 0) {
      for (const auto &e : x)
        std::cout << std::setw(10) << "B" << bucketCounter++;
    }

    flag = 1;
    std::cout << "\n"
              << "C" << classCounter;
    int bucket = 0;
    double total = 0;
    for (const auto &e : x) {
      e >= 25000 ? std::cout << std::setw(9) << 1 << ","
                 : std::cout << std::setw(9) << 0 << ",";
    }
    classCounter++;
  }

  std::vector<int> valuesMesh;

  for (const auto &x : counters) {
    for (const auto &e : x) {
      valuesMesh.emplace_back(e);
    }
  }

  std::sort(valuesMesh.begin(), valuesMesh.end(), std::greater<int>());
  std::cout << std::endl;

  for (auto x : valuesMesh) {
    std::cout << std::setw(9)
              << (double)((double)x / (FORALLS * RUNS * CLASSES)) << "\n";
  }

  return 0;
}