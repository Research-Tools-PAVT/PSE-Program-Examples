#include <PSE.h>
#include <klee/klee.h>
#define FLIPS 3
#define LIMIT 10

int main(int argc, char *argv[]) {

  int sum1 = 0, sum2 = 0, b1, b2, SUM = 0, tmp1[FLIPS], tmp2[FLIPS];

  klee_make_symbolic(&b1, sizeof(b1), "b1_sym");
  klee_make_symbolic(&b2, sizeof(b2), "b2_sym");
  // klee_assume(b1 >= 1 && b1 <= LIMIT);
  // klee_assume(b2 >= 1 && b2 <= LIMIT);

  // generate 3 flips for two coins.
  for (std::size_t i = 0; i < FLIPS; ++i) {

    int temp1, temp2;

    std::string name = "temp_c1_" + std::to_string(i);
    make_pse_symbolic(&temp1, sizeof(temp1), name.c_str(), 1, LIMIT);

    name = "temp_c2_" + std::to_string(i);
    make_pse_symbolic(&temp2, sizeof(temp2), name.c_str(), 1, LIMIT);

    tmp1[i] = temp1;
    if (temp1 >= b1)
      SUM += 1;

    tmp2[i] = temp2;
    if (temp2 >= b2)
      SUM += 1;
  }

  mark_state_winning();
  expected_value("SUM_sym", SUM);

  return 0;
}
