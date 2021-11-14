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
unsigned int microseconds = 1000000;
// for convenience
using json = nlohmann::json;

#ifndef MIN_RANGE
#define MIN_RANGE -2147483646
#endif

#ifndef MAX_RANGE
#define MAX_RANGE 2147483646
#endif

#define CLASSES 4
#define FORALLS 10
#define RUNS 10000
#define BUCKET_SIZE 2

int forall_classes = CLASSES;

void reservoir_sample(int *input, int *sample, int n, int k, int *j_sample) {
  for (int i = k; i < n; i++) {
    int j = 0 + rand() % (i - 1);

    /* Record the PSE Variables */
    if (i - k >= 2)
      j_sample[i - k] = j;

    // COMMENT : Fork Location.
    if (j < k) {
      // Forks and produces the tree.
      sample[j] = input[i];
    }
  }
}

int main() {
  std::freopen("../results/reservoir_v1.txt", "w", stdout);

  std::vector<std::vector<int>> counters(CLASSES,
                                         std::vector<int>(BUCKET_SIZE, 0));
  // json summaryObj;
  while (forall_classes--) {
    srand(time(NULL));
    int forall_samples = FORALLS;
    while (forall_samples--) {

      int n = 10, k = 4;

      int arr[n];
      int pick_index = rand() % (k - 1);

      for (size_t i = 0; i < n; i++) {
        arr[i] = rand() % 14241 + rand() % 62354 + rand() % 5412 + rand();
      }

      int *sample = (int *)malloc(sizeof(int) * k);
      for (int i = 0; i < k; i++) {
        sample[i] = arr[i];
      }

      int runs = RUNS;
      while (runs--) {
        int j_sample[n - k];

        /* PSE Classes */
        /* C0 */
        if (forall_classes == 0) {
          j_sample[0] = k + 1;
          j_sample[1] = k + 1;
        }

        /* C1 */
        if (forall_classes == 1) {
          j_sample[0] = k - 1;
          j_sample[1] = k - 1;
        }

        /* C2 */
        if (forall_classes == 2) {
          j_sample[0] = k - 1;
          j_sample[1] = k + 1;
        }

        /* C3 */
        if (forall_classes == 3) {
          j_sample[0] = k + 1;
          j_sample[1] = k - 1;
        }

        reservoir_sample(arr, sample, n, k, j_sample);
        int ret = 0;
        for (int i = 0; i < k; i++) {
          if (arr[pick_index] == sample[i]) {
            ret = 1;
            break;
          }
        }

        /* PSE Buckets */
        if (ret == 1) {
          counters[forall_classes][0] += 1;
        }
        if (ret == 0) {
          counters[forall_classes][1] += 1;
        }
      }
      /* Random Gen */
      usleep(microseconds);
      free(sample);
    }
    // for (auto i = 0; i < BUCKET_SIZE; i++)
    //   summaryObj["class_" + std::to_string(forall_classes)]
    //             ["bucket_" + std::to_string(i)] = {
    //                 "num_comps", counters[forall_classes - 1][i]};
  }

  // for (const auto &x : counters) {
  //   std::cout << std::endl;
  //   for (const auto &e : x) {
  //     std::cout << std::setw(7) << e << ",";
  //   }
  // }
  // std::cout << std::endl;

  int classCounter = 0;
  int flag = 0;
  for (const auto &x : counters) {
    classCounter++;
    std::cout << std::endl;
    int bucketCounter = 0;
    if (flag == 0)
      for (const auto &e : x)
        std::cout << std::setw(9) << "B" << bucketCounter++;
    flag = 1;
    std::cout << "\n"
              << "C" << classCounter;
    for (const auto &e : x) {
      std::cout << std::setw(9) << e << ", ";
    }
  }

  std::cout << std::endl;

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