#ifndef _PROBHASH_H
#define _PROBHASH_H

#include <unordered_map>

struct prob_hash {
  std::unordered_map<int, unsigned int> map;
};

unsigned int hash(struct prob_hash *prob_hash, int key, unsigned int max);

#endif
