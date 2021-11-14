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

#define CLASSES 2
#define FORALLS 10
#define RUNS 10000
#define BUCKET_SIZE 3

int main() {
  std::freopen("../results/randomized_response.txt", "w", stdout);

  srand(time(NULL));
  std::vector<std::vector<int>> counters(CLASSES,
                                         std::vector<int>(BUCKET_SIZE, 0));
  int forall_classes = CLASSES;
  while (forall_classes--) {
    int forall_samples = FORALLS;
    while (forall_samples--) {
      int runs = RUNS;
      int truth;
      // klee_make_symbolic(&truth, sizeof(truth), "truth");
      // klee_assume(0 <= truth);
      // klee_assume(truth <= 1);

      /* C0 */
      if (forall_classes == 0) {
        truth = 0;
      }

      /* C1 */
      if (forall_classes == 1) {
        truth = 1;
      }

      while (runs--) {
        // 0 = No, 1 = Yes
        int ret = 0;
        int second_flip = (rand() % 50000) % 2;
        int first_flip = (rand() % 50000) % 2;
        // make_pse_symbolic(&first_flip, sizeof(first_flip), "first_flip", 0,
        // 1); 0 = tails; 1 = heads
        if (first_flip == 0) {
          ret = truth;
        } else {
          // make_pse_symbolic(&second_flip, sizeof(second_flip), "second_flip",
          // 0, 1);

          if (second_flip == 1) {
            ret = 1;
          } else {
            ret = 0;
          }
        }

        /* PSE Buckets */
        if (first_flip == 0 && ret == 1) {
          counters[forall_classes][0] += 1;
        }

        if (first_flip == 1 && ret == 1) {
          counters[forall_classes][1] += 1;
        }

        if (ret != 1) {
          counters[forall_classes][2] += 1;
        }

        // Query : ret == truth
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
      std::cout << std::setw(8) << e << ", ";
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