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

#define CLASSES 5
#define FORALLS 10
#define RUNS 1000
#define BUCKET_SIZE 5

int main() {
  srand(time(NULL));
  std::vector<std::vector<int>> counters(CLASSES,
                                         std::vector<int>(BUCKET_SIZE, 0));
  int forall_classes = CLASSES;
  while (forall_classes--) {
    int forall_samples = FORALLS;
    while (forall_samples--) {
      int runs = RUNS;
      int truth = 0;
      // klee_make_symbolic(&truth, sizeof(truth), "truth");
      // klee_assume(0 <= truth);
      // klee_assume(truth <= 1);

      int second_flip = rand() % 2;
      int first_flip = rand() % 2;
      // make_pse_symbolic(&first_flip, sizeof(first_flip), "first_flip", 0, 1);

      // 0 = No, 1 = Yes
      int ret = 0;
      while (runs--) {
        // 0 = tails; 1 = heads
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

        if (ret == truth) {
          // Win
          std::cerr << "success" << std::endl;
        } else {
          std::cerr << "failure" << std::endl;
        }
      }
    }
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