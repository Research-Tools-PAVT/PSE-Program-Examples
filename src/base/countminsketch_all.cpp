#include <PSE.h>
#include <countminsketch.hpp>
#include <iostream>
#include <limits>
#include <math.h>
#include <prob_hash_int.h>
#include <stdlib.h>
#include <time.h>
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
    unsigned int x;
    make_pse_symbolic(&x, sizeof(x), "x_sym", (unsigned int)0,
                      (unsigned int)max);
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
    //    hashval = ((long)hashes[j][0]*item+hashes[j][1])%LONG_PRIME%w;
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
  int c = *str;
  while (c == *str++) {
    hash = ((hash << 5) + hash) + c; /* hash * 33 + c */
  }
  return hash;
}

int main() {
  int n = 4;
  float epsilon = 0.5;
  float gamma = 0.25;
  CountMinSketch c(epsilon, gamma);

  int arr[n];
  for (int i = 0; i < n; i++) {
    //		int temp;
    // klee_make_symbolic(&temp, sizeof(temp), "a_sym");
    arr[i] = i; // temp;
  }
  // for(size_t i = 0; i < n; i++) {
  //   for(size_t j = i + 1; j < n; j++) {
  //     klee_assume(arr[i] != arr[j]);
  //   }
  // }

  for (int i = 0; i < n; i++) {
    c.update(arr[i], 1);
  }

  // c.estimate(arr[0]) > 1 + epsilon*n
  if (c.estimate(arr[0]) > 3) {
    // Should happen with probability less than gamma
    mark_state_winning();
    klee_dump_kquery_state();
  }
  return 0;
}
