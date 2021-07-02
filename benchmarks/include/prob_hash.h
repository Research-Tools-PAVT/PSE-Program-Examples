#ifndef _PROBHASH_H
#define _PROBHASH_H

#include <string>
#include <unordered_map>

struct prob_hash {
  std::unordered_map<std::string, unsigned int> map;
};

unsigned int hash(struct prob_hash *prob_hash, std::string key,
                  unsigned int max);

#endif
