#include <algorithm>
#include <assert.h>
#include <bloom.h>
#include <fcntl.h>
#include <fstream>
#include <functional>
#include <getopt.h> /* getopt */
#include <iomanip>
#include <iostream>
#include <iterator>
#include <json.hpp>
#include <math.h>
#include <prob_hash_int.h>
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

#define CLASSES 2
#define FORALLS 10
#define RUNS 10000
#define BUCKET_SIZE 5
#define MAKESTRING(n) STRING(n)
#define STRING(n) #n

int global_forall_hoisted = -1;
int ghMAX = -1;
std::vector<std::vector<int>> counters(CLASSES,
                                       std::vector<int>(BUCKET_SIZE, 0));

unsigned int hash(struct prob_hash *prob_hash, int key, unsigned int max) {
  auto found = prob_hash->map.find(key);
  // If the key is not in the map, get a random element and rehash
  if (found == prob_hash->map.end()) {
    unsigned int x = 0 + rand() % max;
    global_forall_hoisted = x;
    ghMAX = max;
    // make_pse_symbolic(&x, sizeof(x), "x_sym", (unsigned int)0,
    //                   (unsigned int)max);
    prob_hash->map[key] = x;
    return x;
  } else {
    return found->second;
  }
}

inline static int test_bit_set_bit(unsigned char *buf, unsigned int x,
                                   int set_bit) {
  unsigned int byte = x >> 3;
  unsigned char c = buf[byte]; // expensive memory access
  unsigned int mask = 1 << (x % 8);
  if (c & mask) {
    return 1;
  } else {
    if (set_bit) {
      buf[byte] = c | mask;
    }
    return 0;
  }
}

static int bloom_check_add(struct bloom *bloom, int key, int add) {
  if (bloom->ready == 0) {
    // printf("bloom at %p not initialized!\n", (void *)bloom);
    return -1;
  }

  int hits = 0;
  unsigned int x;
  unsigned int i;

  for (i = 0; i < bloom->hashes; i++) {
    x = hash(&(bloom->hash_fns[i]), key, bloom->bits - 1);
    if (test_bit_set_bit(bloom->bf, x, add)) {
      hits++;
    } else if (!add) {
      // Don't care about the presence of all the bits. Just our own.
      return 0;
    }
  }

  if (hits == bloom->hashes) {
    return 1; // 1 == element already in (or collision)
  }

  return 0;
}

int bloom_init_size(struct bloom *bloom, int entries, double error,
                    unsigned int cache_size) {
  return bloom_init(bloom, entries, error);
}

int bloom_init(struct bloom *bloom, int entries, double error) {
  bloom->ready = 0;

  if (error == 0) {
    return 1;
  }

  bloom->entries = entries;
  bloom->error = error;

  double num = log(bloom->error);
  double denom = 0.480453013918201; // ln(2)^2
  bloom->bpe = -(num / denom);

  double dentries = (double)entries;
  bloom->bits = (int)(dentries * bloom->bpe);

  if (bloom->bits % 8) {
    bloom->bytes = (bloom->bits / 8) + 1;
  } else {
    bloom->bytes = bloom->bits / 8;
  }

  bloom->hashes = (int)ceil(0.693147180559945 * bloom->bpe); // ln(2)
  // printf("Hashes = %d\n", bloom->hashes);
  // printf("Bits = %d\n", bloom->bits);

  bloom->bf = (unsigned char *)calloc(bloom->bytes, sizeof(unsigned char));
  if (bloom->bf == NULL) { // LCOV_EXCL_START
    return 1;
  } // LCOV_EXCL_STOP

  bloom->hash_fns = new struct prob_hash[bloom->hashes];
  bloom->ready = 1;
  return 0;
}

int bloom_check(struct bloom *bloom, int key) {
  return bloom_check_add(bloom, key, 0);
}

int bloom_add(struct bloom *bloom, int key) {
  return bloom_check_add(bloom, key, 1);
}

void bloom_print(struct bloom *bloom) {
  // printf("bloom at %p\n", (void *)bloom);
  // printf(" ->entries = %d\n", bloom->entries);
  // printf(" ->error = %f\n", bloom->error);
  // printf(" ->bits = %d\n", bloom->bits);
  // printf(" ->bits per elem = %f\n", bloom->bpe);
  // printf(" ->bytes = %d\n", bloom->bytes);
  // printf(" ->hash functions = %d\n", bloom->hashes);
}

void bloom_free(struct bloom *bloom) {
  if (bloom->ready) {
    free(bloom->bf);
    // Delete the whole array of hash_fns.
    delete[] bloom->hash_fns;

    // Must set to nullptr. For re-use.
    bloom->bf = nullptr;
    bloom->hash_fns = nullptr;
  }
  bloom->ready = 0;
}

int bloom_reset(struct bloom *bloom) {
  if (!bloom->ready)
    return 1;
  memset(bloom->bf, 0, bloom->bytes);
  return 0;
}

const char *bloom_version() { return MAKESTRING(BLOOM_VERSION); }

int main() {
  std::freopen("../results/bloomfilter.txt", "w", stdout);

  srand(time(NULL));

  int forall_classes = CLASSES;
  while (forall_classes--) {
    int forall_samples = FORALLS;
    while (forall_samples--) {
      int runs = RUNS;
      double error = 0.39;
      int n = 3;
      int arr[n + 1];

      // TODO : Distinct Array.
      for (int i = 0; i < n; i++) {
        arr[i] = i + rand() % 57 + rand() % 101 + rand() % 481243;
      }

      // arr[n] is checked, two cases one duplicate,
      // other not duplicate.

      /* C0 */
      /* arr[0] == arr[n] */
      if (forall_classes == 0) {
        arr[n] = arr[0];
      }

      /* C1 */
      /* arr[0] != arr[n] */
      if (forall_samples == 1) {
        if (rand() % 5000 == 0)
          arr[n] = arr[0] + 1 + rand() % 10;
        else
          arr[n] = arr[0] - 1 - rand() % 10;
      }

      while (runs--) {
        int ret = 0;
        struct bloom bloom;
        bloom_init(&bloom, n, error);

        for (int i = 0; i < n; i++) {
          bloom_add(&bloom, arr[i]);
        }

        ret = bloom_check(&bloom, arr[n]);
        bloom_free(&bloom);

        // if (ret == 1) {
        //   std::cerr << global_forall_hoisted << std::endl;
        // }
        /* PSE Buckets */
        // if (global_forall_hoisted >= 0 &&
        //     (global_forall_hoisted <= (ghMAX / 3)) && (ret == 1))
        //   counters[forall_classes][0] += 1;

        // if (global_forall_hoisted > (ghMAX / 3) &&
        //     global_forall_hoisted <= ((2 * ghMAX) / 3) && (ret == 1))
        //   counters[forall_classes][1] += 1;

        // if (global_forall_hoisted > ((2 * ghMAX) / 3) && (ret == 1))
        //   counters[forall_classes][2] += 1;

        if (global_forall_hoisted == 1) {
          counters[forall_classes][0] += 1;
        }
        if (global_forall_hoisted == 2) {
          counters[forall_classes][1] += 1;
        }
        if (global_forall_hoisted == 3) {
          counters[forall_classes][2] += 1;
        }
        if (global_forall_hoisted == 4) {
          counters[forall_classes][3] += 1;
        } else {
          std::cout << global_forall_hoisted << std::endl;
          counters[forall_classes][4] += 1;
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