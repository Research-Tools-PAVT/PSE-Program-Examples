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
  printf("Hashes = %d\n", bloom->hashes);
  printf("Bits = %d\n", bloom->bits);

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
  int entries = 0, add_item = 0, search_item = 1, win = 0, loop_count = 0,
      termCount = 0;
  double error = 0.00;
  std::vector<std::string> inputs = {"Zach1",  "Zach2",     "Justin1",
                                     "Sumit1", "Subhajit1", "Justin2"};

  std::default_random_engine generator;
  std::uniform_int_distribution<int> range_dist(0, 5);
  std::uniform_real_distribution<double> error_dist(0.01, 0.99);

  entries = 1;
  error = error_dist(generator);
  add_item = range_dist(generator);
  search_item = range_dist(generator);
  scanf("%d", &termCount);

  while (termCount--) {

    // For each setting of the forAlls,
    // We run the program termCount number of times.
    struct bloom bloom;
    bloom_init(&bloom, entries, error);
    bloom_add(&bloom, inputs[add_item]);

    // Different Elem.
    if (bloom_check(&bloom, inputs[search_item])) {
      // klee_dump_kquery_state();
      win++;
    }

    bloom_free(&bloom);
    loop_count++;
  }

  auto pwin = (double)win / loop_count;
  std::cout << "Prob Assert : " << pwin << "\n";
  return 0;
}

// @brief Error
// AddressSanitizer:DEADLYSIGNAL
// =================================================================
// ==295351==ERROR: AddressSanitizer: SEGV on unknown address 0x6020021ac76e (pc
// 0x000000507d0e bp 0x7ffc1f7eb450 sp 0x7ffc1f7eb400 T0)
// ==295351==The signal is caused by a READ memory access.
//     #0 0x507d0e in test_bit_set_bit(unsigned char*, unsigned int, int)
//     bloomfilter.cpp #1 0x506616 in bloom_check_add(bloom*,
//     std::__cxx11::basic_string<char, std::char_traits<char>,
//     std::allocator<char> >, int) bloomfilter.cpp #2 0x506906 in
//     bloom_add(bloom*, std::__cxx11::basic_string<char,
//     std::char_traits<char>, std::allocator<char> >)
//     (/home/zcluster55/Documents/Research/PSE-Program-Examples/baseline-exp/bin/bloomfilter+0x506906)
//     #3 0x50772f in main
//     (/home/zcluster55/Documents/Research/PSE-Program-Examples/baseline-exp/bin/bloomfilter+0x50772f)
//     #4 0x7ff0c452c0b2 in __libc_start_main
//     /build/glibc-eX1tMB/glibc-2.31/csu/../csu/libc-start.c:308:16 #5 0x42556d
//     in _start
//     (/home/zcluster55/Documents/Research/PSE-Program-Examples/baseline-exp/bin/bloomfilter+0x42556d)

// AddressSanitizer can not provide additional info.
// SUMMARY: AddressSanitizer: SEGV bloomfilter.cpp in test_bit_set_bit(unsigned
// char*, unsigned int, int)
// ==295351==ABORTING