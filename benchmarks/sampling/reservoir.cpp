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

#define CLASSES 5
#define FORALLS 10
#define RUNS 10000
#define BUCKET_SIZE 2

int forall_classes = CLASSES;

void reservoir_sample(int *input, int *sample, int n, int k, int *j_sample) {
  int count = 0;
  for (int i = k; i < n; i++) {
    count++;
    int j = 0 + rand() % (i - 1);
    /* Record the PSE Variables */
    j_sample[i - k] = j;

    // COMMENT : Fork Location.
    if (j < k) {
      // Forks and produces the tree.
      sample[j] = input[i];
    }
  }
}

int main() {
  std::vector<std::vector<int>> counters(CLASSES,
                                         std::vector<int>(BUCKET_SIZE, 0));
  json summaryObj;
  while (forall_classes--) {
    srand(time(NULL));
    int forall_samples = FORALLS;
    while (forall_samples--) {

      int n = 0, k = 0;
      /* Map to forall classes */
      if (forall_classes == 4) {
        // (k < n)
        n = 8 + rand() % 100;
        k = rand() % 100 - 5;
        while (k >= n) {
          k = 2 + rand() % 100;
        }
      }
      if (forall_classes == 3) {
        // ((k >= n / 2) && (k < (n / 2 + n / 4)))
        n = 8 + rand() % 100;
        k = (n >> 1) + rand() % 2;
      }
      if (forall_classes == 2) {
        // (k >= (n / 2 + n / 4) && (k < (n / 2 + n / 4 + n / 8)))
        n = 8 + rand() % 100;
        k = (n >> 1) + (n >> 2) + rand() % 2;
      }
      if (forall_classes == 1) {
        // (k >= (n / 2 + n / 4 + n / 8))
        n = 8 + rand() % 100;
        k = (n >> 1) + (n >> 2) + (n >> 3) + rand() % 2;
      }
      if (forall_classes == 0) {
        // (k <= n / 2)
        n = 8 + rand() % 100;
        k = (n >> 1) - (rand() % 2);
      }

      int arr[n];
      int pick_index = rand() % (n - 1);

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

        reservoir_sample(arr, sample, n, k, j_sample);
        int ret = 0;
        for (int i = 0; i < k; i++) {
          if (arr[pick_index] == sample[i]) {
            ret = 1;
            break;
          }
        }
        printf("Class : %d, \n\tForall : %d, Runs : %d, Pick, %d, Sample "
               "Matched? : %d\n",
               forall_classes, forall_samples, runs, pick_index, ret);
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
      e >= 30000 ? std::cout << std::setw(5) << 1 << ","
                 : std::cout << std::setw(5) << 0 << ",";
    }
  }
  std::cout << std::endl;
  return 0;
}