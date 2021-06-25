#include <cstdio>
#include <init.h>
#include <iostream>
#include <string>
#include <unordered_map>
#include <vector>

int main() {
  /**
   * @brief Initialize the FORALL Variables.
   *
   */
  int termCount = 0, win = 0, loop_count = 0;
  scanf("%d", &termCount);

  while (termCount--) {
    std::string str = "";
    std::getline(std::cin, str);
    std::cout << str << "\n";
  }

  return 0;
}