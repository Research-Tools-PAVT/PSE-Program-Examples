/*
 *  Copyright (c) 2012-2019, Jyri J. Virkki
 *  All rights reserved.
 *
 *  This file is under BSD license. See LICENSE file.
 */

/*
 * Refer to bloom.h for documentation on the public interfaces.
 */

#include <assert.h>
#include <bloom.h>
#include <cstdio>
#include <fcntl.h>
#include <iostream>
#include <limits>
#include <math.h>
#include <prob_hash.h>
#include <random>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <string>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

#define MAKESTRING(n) STRING(n)
#define STRING(n) #n

unsigned int hash(struct prob_hash *prob_hash, std::string key,
                  unsigned int max) {
  auto found = prob_hash->map.find(key);

  // If the key is not in the map, get a random element and rehash
  if (found == prob_hash->map.end()) {
    // Randomly sample PSE Variable from a given distribution.
    std::default_random_engine generator;
    std::uniform_int_distribution<int> int_dist(0, (int)max);
    unsigned int x = int_dist(generator);
    // make_pse_symbolic(&x, sizeof(x), "x_sym", 0, (int)max);
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

static int bloom_check_add(struct bloom *bloom, std::string key, int add) {
  if (bloom->ready == 0) {
    printf("bloom at %p not initialized!\n", (void *)bloom);
    return -1;
  }

  int hits = 0;
  unsigned int x;
  unsigned int i;

  for (i = 0; i < bloom->hashes; i++) {
    x = hash(&(bloom->hash_fns[i]), key, bloom->bits);
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

  bloom->bf = (unsigned char *)malloc(bloom->bytes * sizeof(unsigned char));
  if (bloom->bf == NULL) { // LCOV_EXCL_START
    return 1;
  } // LCOV_EXCL_STOP

  bloom->hash_fns = new struct prob_hash[bloom->hashes];
  bloom->ready = 1;
  return 0;
}

int bloom_check(struct bloom *bloom, std::string key) {
  return bloom_check_add(bloom, key, 0);
}

int bloom_add(struct bloom *bloom, std::string key) {
  return bloom_check_add(bloom, key, 1);
}

void bloom_print(struct bloom *bloom) {
  printf("bloom at %p\n", (void *)bloom);
  printf(" -> entries = %d\n", bloom->entries);
  printf(" -> error = %f\n", bloom->error);
  printf(" -> bits = %d\n", bloom->bits);
  printf(" -> bits per elem = %f\n", bloom->bpe);
  printf(" -> bytes = %d\n", bloom->bytes);
  printf(" -> hash functions = %d\n", bloom->hashes);
}

void bloom_free(struct bloom *bloom) {
  if (bloom->ready) {
    free(bloom->bf);
    delete[] bloom->hash_fns;

    // Re-use
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

  /**
   * @brief We randomly supply a set of forall values.
   *
   * We run the program multiple times, each time with a
   * different setting of the ForAll variables.
   */
  int entries = 0, add_item = 0, search_item = 0, N = 0;
  long double error = 0.00;

  // For each setting of the forAlls,
  // We run the program termCount number of times.

  scanf("%d", &N);
  scanf("%d", &entries);
  scanf("%Lf", &error);
  scanf("%d", &add_item);
  scanf("%d", &search_item);

  std::vector<std::string> inputs;

  assert(add_item < N && add_item >= 0);
  assert(search_item < N && search_item >= 0);

  std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');

  while (N--) {
    std::string temp = "";
    std::getline(std::cin, temp);
    inputs.emplace_back(temp);
  }

  struct bloom bloom;
  bloom_init(&bloom, entries, error);
  bloom_add(&bloom, inputs[add_item]);

  // Different Elem.
  if (bloom_check(&bloom, inputs[search_item])) {
    // klee_dump_kquery_state();
    std::cout << "1"
              << "\n";
  } else {
    std::cout << "-1"
              << "\n";
  }

  bloom_free(&bloom);
}
