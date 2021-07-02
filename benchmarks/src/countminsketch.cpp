#include <cmath>
#include <countminsketch.hpp>
#include <cstdlib>
#include <ctime>
#include <iostream>
#include <limits>
#include <prob_hash_int.h>
#include <random>
using namespace std;

/**
   Class definition for CountMinSketch.
   public operations:
   // overloaded updates
   void update(int item, int c);
   void update(char *item, int c);
   // overloaded estimates
   unsigned int estimate(int item);
   unsigned int estimate(char *item);
**/

unsigned int my_hash(struct prob_hash *prob_hash, int key, unsigned int max) {
  auto found = prob_hash->map.find(key);

  // If the key is not in the map, get a random element and rehash
  if (found == prob_hash->map.end()) {
    std::default_random_engine generator;
    std::uniform_int_distribution<int> range_dist(0, (int)max);
    unsigned int x = range_dist(generator);
    // make_pse_symbolic(&x, sizeof(x), "x_sym", 0, (int)max);
    prob_hash->map[key] = x;
    return x;
  } else {
    return found->second;
  }
}

// CountMinSketch constructor
// ep -> error 0.01 < ep < 1 (the smaller the better)
// gamma -> probability for error (the smaller the better) 0 < gamm < 1
CountMinSketch::CountMinSketch(float ep, float gamm) {
  if (!(0.009 <= ep && ep < 1)) {
    cout << "eps must be in this range: [0.01, 1)" << endl;
    exit(EXIT_FAILURE);
  } else if (!(0 < gamm && gamm < 1)) {
    cout << "gamma must be in this range: (0,1)" << endl;
    exit(EXIT_FAILURE);
  }
  eps = ep;
  gamma = gamm;
  w = ceil(exp(1) / eps);
  d = ceil(log(1 / gamma));
  total = 0;
  // initialize counter array of arrays, C
  C = new int *[d];
  unsigned int i, j;
  for (i = 0; i < d; i++) {
    C[i] = new int[w];
    for (j = 0; j < w; j++) {
      C[i][j] = 0;
    }
  }
  hash_fns = new struct prob_hash[d];

  // initialize d pairwise independent hashes
  // srand(time(NULL));
  // hashes = new int* [d];
  // for (i = 0; i < d; i++) {
  //   hashes[i] = new int[2];
  //   genajbj(hashes, i);
  // }
}

// CountMinSkectch destructor
CountMinSketch::~CountMinSketch() {
  // free array of counters, C
  unsigned int i;
  for (i = 0; i < d; i++) {
    delete[] C[i];
  }
  delete[] C;

  // free array of hash values
  // for (i = 0; i < d; i++) {
  //   delete[] hashes[i];
  // }
  // delete[] hashes;
  delete[] hash_fns;
}

// CountMinSketch totalcount returns the
// total count of all items in the sketch
unsigned int CountMinSketch::totalcount() { return total; }

// countMinSketch update item count (int)
void CountMinSketch::update(int item, int c) {
  total = total + c;
  unsigned int hashval = 0;
  for (unsigned int j = 0; j < d; j++) {
    hashval = my_hash(&hash_fns[j], item, w - 1);
    C[j][hashval] = C[j][hashval] + c;
  }
}

// countMinSketch update item count (string)
void CountMinSketch::update(const char *str, int c) {
  int hashval = hashstr(str);
  update(hashval, c);
}

// CountMinSketch estimate item count (int)
unsigned int CountMinSketch::estimate(int item) {
  int minval = numeric_limits<int>::max();
  unsigned int hashval = 0;
  for (unsigned int j = 0; j < d; j++) {
    // hashval = ((long)hashes[j][0]*item+hashes[j][1])%LONG_PRIME%w;
    hashval = my_hash(&hash_fns[j], item, w - 1);
    minval = MIN(minval, C[j][hashval]);
  }
  return minval;
}

// CountMinSketch estimate item count (string)
unsigned int CountMinSketch::estimate(const char *str) {
  int hashval = hashstr(str);
  return estimate(hashval);
}

// generates aj,bj from field Z_p for use in hashing
void CountMinSketch::genajbj(int **hashes, int i) {
  hashes[i][0] = int(float(rand()) * float(LONG_PRIME) / float(RAND_MAX) + 1);
  hashes[i][1] = int(float(rand()) * float(LONG_PRIME) / float(RAND_MAX) + 1);
}

// generates a hash value for a sting
// same as djb2 hash function
unsigned int CountMinSketch::hashstr(const char *str) {
  unsigned long hash = 5381;
  int c;
  while (c = *str++) {
    hash = ((hash << 5) + hash) + c; /* hash * 33 + c */
  }
  return hash;
}

int main() {

  std::default_random_engine generator;
  std::uniform_int_distribution<int> dataRange(INT32_MIN, INT32_MAX);
  std::uniform_real_distribution<float> ep_range(0.01, 1);
  std::uniform_real_distribution<float> gamm_range(0, 1);

  // float ep = ep_range(generator);
  // float gamm = gamm_range(generator);
  int termCount = 0, win = 0, loop_count = 0;
  std::vector<std::string> dataSet = {"hello", "World"};
  scanf("%d", &termCount);

  while (termCount--) {

    // Try with concrete values as of now.
    // We can try with Foralls later.
    CountMinSketch c(0.01, 0.1);
    // float ep = ep_range(generator);
    // float gamm = gamm_range(generator);
    // CountMinSketch c(ep, gamm);

    c.update(dataSet[0].c_str(), 1); // Update number Could be foralls.
    c.update(dataRange(generator), 2);
    c.update(dataSet[0].c_str(), 1);

    auto ret = c.estimate(dataSet[0].c_str());
    if (ret != 2) {
      // klee_dump_kquery_state();
      win++;
    }
    loop_count++;
  }

  auto pwin = (double)win / loop_count;
  std::cout << "Prob Assert : " << pwin << "\n";
  return 0;
}