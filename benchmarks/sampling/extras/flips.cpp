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
#define BUCKET_SIZE 4
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
      std::unordered_map<int, int> forallSamplesDist;
      for (int i = 0; i < BUCKET_SIZE; i++)
        forallSamplesDist[i] = 0;

      int runs = RUNS;
      int b1 = 0, b2 = 0, tmp1[FLIPS], tmp2[FLIPS];

      // b1 = rand() % 10000;
      // b2 = rand() % 10000;
      tmp1[0] = rand() % 10000;
      tmp2[0] = rand() % 10000;

      /* FORALL Buckets */
      /* C0 >= first tmp */
      if (forall_classes == 0) {
        b1 = tmp1[0] + rand() % 100;
        b2 = tmp2[0] + rand() % 100;
      }

      /* C1 <= first tmp */
      else if (forall_classes == 1) {
        b1 = tmp1[0] - (1 + rand() % 10);
        b2 = tmp2[0] - (1 + rand() % 10);
      }

      /* C2 */
      else if (forall_classes == 2) {
        b1 = tmp1[0] + 1 + rand() % 100;
        b2 = tmp2[0] - (1 + rand() % 10);
      }

      /* C3 */
      else {
        b1 = tmp1[0] - (1 + rand() % 10);
        b2 = tmp2[0] + 1 + rand() % 100;
      }

      /* FORALL Buckets */
      /* C0 >= first tmp */
      // if (forall_classes == 0) {
      //   b1 = 5000 + rand() % 2;
      //   b2 = 5000 + rand() % 2;
      // }

      // /* C1 <= first tmp */
      // if (forall_classes == 1) {
      //   b1 = 5000 - rand() % 5;
      //   b2 = 5000 - rand() % 5;
      // }

      // /* C2 */
      // if (forall_classes == 2) {
      //   b1 = 5000 + rand() % 2;
      //   b2 = 5000 - rand() % 5;
      // }

      // /* C3 */
      // if (forall_classes == 3) {
      //   b1 = 5000 - rand() % 5;
      //   b2 = 5000 + rand() % 2;
      // }

      while (runs--) {
        int sum1 = 0, sum2 = 0, SUM = 0;

        // generate 3 flips for coin-1 and coin-2.
        for (std::size_t i = 0; i < FLIPS; ++i) {

          if (i != 0) {
            tmp1[i] = rand() % 10000;
            tmp2[i] = rand() % 10000;
          }

          if (tmp1[i] >= b1)
            sum1 += 1;

          if (tmp2[i] >= b2)
            sum2 += 1;
        }

        SUM = sum1 + sum2;

        // if (SUM == 3 || SUM == 6)
        //   forallSamplesDist[0] += 1;
        // else if (SUM == 1 || SUM == 2)
        //   forallSamplesDist[1] += 1;
        // else if (SUM == 4)
        //   forallSamplesDist[2] += 1;
        // else
        //   forallSamplesDist[3] += 1;

        if (SUM == 5 || SUM == 6 || SUM == 4)
          forallSamplesDist[0] += 1;
        else if (SUM == 3)
          forallSamplesDist[1] += 1;
        else if (SUM == 2 || SUM == 1)
          forallSamplesDist[2] += 1;
        else
          forallSamplesDist[3] += 1;
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

  int classCounter = 0;
  int flag = 0;
  for (const auto &x : counters) {
    std::cout << std::endl;
    int bucketCounter = 0;
    if (flag == 0)
      for (const auto &e : x)
        std::cout << std::setw(8) << "B" << bucketCounter++;
    flag = 1;
    std::cout << "\n"
              << "C" << classCounter << ", " << classCounter << ",";
    for (const auto &e : x) {
      std::cout << std::setw(7) << e << ", ";
    }
    classCounter++;
  }

  std::cout << std::endl;
  std::cout << std::endl;

  classCounter = 0;
  flag = 0;
  for (const auto &x : counters) {
    std::cout << std::endl;
    int bucketCounter = 0;
    if (flag == 0)
      for (const auto &e : x)
        std::cout << std::setw(4) << "B" << bucketCounter++;
    flag = 1;
    std::cout << "\n"
              << "C" << classCounter << ", " << classCounter << ",";
    for (const auto &e : x) {
      (e >= 7000) ? std::cout << std::setw(3) << 1 << ", "
                  : std::cout << std::setw(3) << 0 << ", ";
    }
    classCounter++;
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
    std::cout << std::setw(9) << (double)((double)x / (1)) << "\n";
  }

  return 0;
}
