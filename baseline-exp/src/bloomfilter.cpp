#include <assert.h>
#include <bloom.h>
#include <cstdio>
#include <fcntl.h>
#include <iostream>
#include <math.h>
#include <prob_hash.h>
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
    unsigned int x;
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

  bloom->bf = (unsigned char *)calloc(bloom->bytes, sizeof(unsigned char));
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
  printf(" ->entries = %d\n", bloom->entries);
  printf(" ->error = %f\n", bloom->error);
  printf(" ->bits = %d\n", bloom->bits);
  printf(" ->bits per elem = %f\n", bloom->bpe);
  printf(" ->bytes = %d\n", bloom->bytes);
  printf(" ->hash functions = %d\n", bloom->hashes);
}

void bloom_free(struct bloom *bloom) {
  if (bloom->ready) {
    free(bloom->bf);
    free(bloom->hash_fns);
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
  struct bloom bloom;
  bloom_init(&bloom, 1, 0.1);
  bloom_add(&bloom, "Zach1");
  if (bloom_check(&bloom, "Justin")) {
    // klee_dump_kquery_state();
    std::cout << "Found !\n";
  }
  bloom_free(&bloom);
  return 0;
}