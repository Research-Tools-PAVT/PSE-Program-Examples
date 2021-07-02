#include <cstdio>
#include <deque>
#include <init.h>
#include <iostream>
#include <json.hpp>
#include <list>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

using json = nlohmann::json;
// https://github.com/nlohmann/json#conversion-from-stl-containers

int main() {
  /**
   * @brief Initialize the FORALL Variables.
   *
   */
  int termCount = 0, win = 0, loop_count = 0;
  scanf("%d", &termCount);

  std::vector<int> c_vector{1, 2, 3, 4};
  json j_vec(c_vector);
  // [1, 2, 3, 4]

  std::deque<double> c_deque{1.2, 2.3, 3.4, 5.6};
  json j_deque(c_deque);
  // [1.2, 2.3, 3.4, 5.6]

  std::unordered_set<std::string> c_uset{"one", "two", "three", "four", "one"};
  json j_uset(c_uset); // only one entry for "one" is used
  // maybe ["two", "three", "four", "one"]

  std::unordered_multiset<std::string> c_umset{"one", "two", "one", "four"};
  json j_umset(c_umset); // both entries for "one" are used
                         // maybe ["one", "two", "one", "four"]

  std::multimap<std::string, bool> c_mmap{
      {"one", true}, {"two", true}, {"three", false}, {"three", true}};
  json j_mmap(c_mmap); // only one entry for key "three" is used
  // maybe {"one": true, "two": true, "three": true}

  std::unordered_multimap<std::string, bool> c_ummap{
      {"one", true}, {"two", true}, {"three", false}, {"three", true}};
  json j_ummap(c_ummap); // only one entry for key "three" is used
                         // maybe {"one": true, "two": true, "three": true}

  while (termCount--) {
    std::cout << j_uset << "\n";
    std::cout << j_ummap << "\n";
    std::cout << j_mmap << "\n";
  }

  return 0;
}