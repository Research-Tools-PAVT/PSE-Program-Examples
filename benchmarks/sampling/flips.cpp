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
#define FLIPS 3
#define KLEE

#ifdef INSTRUMENT
#undef KLEE
#endif

// #ifdef KLEE
// #include <PSE.h>
// #endif

#ifdef INSTRUMENT
#define LIMIT 10
#define RUNS 100
#endif

using json = nlohmann::json;
json summaryObj, forallBuckets, pseBuckets;

std::vector<int> getPSERunCounts(std::bernoulli_distribution d1,
                                 std::bernoulli_distribution d2, double bias1,
                                 double bias2, int b1, int b2, int FORALLS,
                                 int PSE_RUNS, std::mt19937 rng) {
  int B1 = 0, B2 = 0, B3 = 0, B4 = 0;

  while (PSE_RUNS > 0) {
    int sum1 = 0;
    int sum2 = 0;
    int coin1[3], coin2[3];

    // generate 3 flips
    for (std::size_t i = 0; i < FLIPS; ++i) {
      coin1[i] = d1(rng);
      sum1 += coin1[i];
    }

    // generate 3 flips
    for (std::size_t i = 0; i < FLIPS; ++i) {
      coin2[i] = d2(rng);
      sum2 += coin2[i];
    }

    int SUM = sum1 + sum2;
    if (SUM == 0 || SUM == 1 || SUM == 2) {
      pseBuckets["FORALL_" + std::to_string(FORALLS)]["B1"] +=
          {{"FORALLS", FORALLS},
           {"b1", b1},
           {"b2", b2},
           {"SUM1", sum1},
           {"SUM2", sum2}};
      B1++;
    }

    if (SUM == 3 || SUM == 4) {
      pseBuckets["FORALL_" + std::to_string(FORALLS)]["B2"] +=
          {{"FORALLS", FORALLS},
           {"b1", b1},
           {"b2", b2},
           {"SUM1", sum1},
           {"SUM2", sum2}};
      B2++;
    }

    if (SUM == 5) {
      pseBuckets["FORALL_" + std::to_string(FORALLS)]["B3"] +=
          {{"FORALLS", FORALLS},
           {"b1", b1},
           {"b2", b2},
           {"SUM1", sum1},
           {"SUM2", sum2}};
      B3++;
    }

    if (SUM == 6) {
      pseBuckets["FORALL_" + std::to_string(FORALLS)]["B4"] +=
          {{"FORALLS", FORALLS},
           {"b1", b1},
           {"b2", b2},
           {"SUM1", sum1},
           {"SUM2", sum2}};
      B4++;
    }
    PSE_RUNS--;
  }
  // std::cout << "B1 : " << std::setw(3) << B1 << ", B2 : " << std::setw(3) <<
  // B2
  //           << ", B3 : " << std::setw(3) << B3 << ", B4 : " << std::setw(3)
  //           << B4;
  std::vector<int> retCounts = {B1, B2, B3, B4};
  return retCounts;
}

int main(int argc, char *argv[]) {

  /*
    Forall Variables.
  */
  int b1 = 0, b2 = 0;
  double bias1 = 0.0000;
  double bias2 = 0.0000;

#ifdef INSTRUMENT
  // init
  std::random_device rd{};
  std::mt19937 rng{rd()};
  std::default_random_engine generator;

  std::vector<std::pair<int, int>> b1Dist, b2Dist;

  /* f1 */
  b1Dist.emplace_back(std::make_pair(1, 9999));
  b2Dist.emplace_back(std::make_pair(1, 9999));

  /* f2 */
  b1Dist.emplace_back(std::make_pair(80001, 100000));
  b2Dist.emplace_back(std::make_pair(80001, 100000));

  /* f3 */
  b1Dist.emplace_back(std::make_pair(80001, 100000));
  b2Dist.emplace_back(std::make_pair(1, 9999));

  /* f4 */
  b1Dist.emplace_back(std::make_pair(1, 9999));
  b2Dist.emplace_back(std::make_pair(80001, 100000));

  int i = 4;
  while (i--) {
    int FORALLS = LIMIT;
    std::vector<int> totalCounts = {0, 0, 0, 0};
    while (FORALLS--) {
      std::uniform_int_distribution<int> distribution1(b1Dist[i].first,
                                                       b1Dist[i].second);
      std::uniform_int_distribution<int> distribution2(b2Dist[i].first,
                                                       b2Dist[i].second);
      b1 = distribution1(generator);
      b2 = distribution2(generator);
      bias1 = (double)(b1) / 100000;
      bias2 = (double)(b2) / 100000;
      std::cout << "\nF" << std::to_string(4 - i) << "\n";
      std::cout << bias1 << ", " << bias2 << std::endl;
      std::bernoulli_distribution d1(bias1);
      std::bernoulli_distribution d2(bias2);
      forallBuckets["f" + std::to_string(4 - i)] += {{"b1", b1}, {"b2", b2}};
      auto retCounts =
          getPSERunCounts(d1, d2, bias1, bias2, b1, b2, FORALLS, RUNS, rng);
      int index = 0;
      for (const auto elem : retCounts) {
        totalCounts[index] += elem;
        index++;
      }
    }
    std::cout << "\n\t";
    for (const auto elems : totalCounts) {
      std::cout << "\\multirow{2}{*}{" << elems << "} & \n";
    }
    std::cout << "\n";
    bias1 = -0.1;
    bias2 = -0.1;
  }

  std::fstream fs;
  std::string filename1 = std::string("summary.json");
  fs.open(filename1.c_str(), std::fstream::out);

  summaryObj["ForAlls"] = forallBuckets;
  summaryObj["pseLogs"] = pseBuckets;
  fs << std::setw(4) << summaryObj << "\n";

  fs.close();
#endif
  return 0;
}