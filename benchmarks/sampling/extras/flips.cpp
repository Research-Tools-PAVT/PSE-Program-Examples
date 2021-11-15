#include <algorithm>
#include <assert.h>
#include <fcntl.h>
#include <fstream>
#include <functional>
#include <getopt.h> /* getopt */
#include <iomanip>
#include <iostream>
#include <iterator>
#include <json.hpp>
#include <math.h>
#include <random>
#include <set>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <string>
#include <sys/stat.h>
#include <sys/types.h>
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
#define RUNS 100000
#define BUCKET_SIZE 7
#define FLIPS 3

int main(void) {
  std::freopen("../results/flips.txt", "w", stdout);
  srand(time(NULL));
  std::vector<std::vector<int>> counters(CLASSES,
                                         std::vector<int>(BUCKET_SIZE, 0));
  int forall_classes = CLASSES;
  while (forall_classes--) {
    int forall_samples = FORALLS;
    while (forall_samples--) {
      int runs = RUNS;
      int b1 = 0, b2 = 0, temp1arr[FLIPS], temp2arr[FLIPS];

      /* FORALL Buckets */
      /* C0 >= 8000 */
      if (forall_classes == 0) {
        b1 = 8001 + rand() % (10000 - 8000);
        b2 = 8001 + rand() % (10000 - 8000);
      }

      /* C1 <= 2500 */
      if (forall_classes == 1) {
        b1 = rand() % 8000;
        b2 = rand() % 8000;
      }

      /* C2 */
      if (forall_classes == 2) {
        b1 = 8001 + rand() % (10000 - 8000);
        b2 = rand() % 8000;
      }

      /* C3 */
      if (forall_classes == 3) {
        b1 = rand() % 8000;
        b2 = 8001 + rand() % (10000 - 8000);
      }

      while (runs--) {
        int sum1 = 0, sum2 = 0, SUM;

        // generate 3 flips for coin-1
        for (std::size_t i = 0; i < FLIPS; ++i) {
          // Baised Coin-1.
          int coin_curr1;
          temp1arr[i] = rand() % 10000;
          if (temp1arr[i] >= b1)
            coin_curr1 = 1;
          else
            coin_curr1 = 0;
          sum1 += coin_curr1;
        }

        // generate 3 flips for coin-2
        for (std::size_t i = 0; i < FLIPS; ++i) {
          // Baised Coin-2
          int coin_curr2;
          temp2arr[i] = rand() % 10000;
          if (temp2arr[i] >= b2)
            coin_curr2 = 1;
          else
            coin_curr2 = 0;
          sum2 += coin_curr2;
        }

        SUM = sum1 + sum2;
        counters[forall_classes][SUM] += 1;
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
        std::cout << std::setw(8) << "B" << bucketCounter++;
    flag = 1;
    std::cout << "\n"
              << "C" << classCounter;
    for (const auto &e : x) {
      std::cout << std::setw(7) << e << ", ";
    }
  }

  std::cout << std::endl;
  std::cout << std::endl;

  classCounter = 0;
  flag = 0;
  for (const auto &x : counters) {
    classCounter++;
    std::cout << std::endl;
    int bucketCounter = 0;
    if (flag == 0)
      for (const auto &e : x)
        std::cout << std::setw(4) << "B" << bucketCounter++;
    flag = 1;
    std::cout << "\n"
              << "C" << classCounter;
    for (const auto &e : x) {
      (e >= 98000) ? std::cout << std::setw(3) << 1 << ", "
                   : std::cout << std::setw(3) << 0 << ", ";
    }
  }

  std::cout << std::endl;
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
