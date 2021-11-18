#include <PSE.h>
#include <klee/klee.h>
#define FLIPS 3
#define LIMIT 5

int main(int argc, char *argv[]) {

  int sum1 = 0, sum2 = 0, b1, b2, SUM, tmp1[FLIPS], tmp2[FLIPS];

  klee_make_symbolic(&b1, sizeof(b1), "b1_sym");
  klee_make_symbolic(&b2, sizeof(b2), "b2_sym");
  klee_assume(b1 >= 1 && b1 <= LIMIT);
  klee_assume(b2 >= 1 && b2 <= LIMIT);

  klee_make_symbolic(&SUM, sizeof(SUM), "SUM_sym");
  SUM = 0;

  // generate 3 flips for coin-1
  for (std::size_t i = 0; i < FLIPS; ++i) {
    // Baised Coin-1.
    int temp1;
    std::string name = "temp_c1_" + std::to_string(i);
    make_pse_symbolic(&temp1, sizeof(temp1), name.c_str(), 1, LIMIT);
    tmp1[i] = temp1;
    if (temp1 >= b1)
      sum1 += 1;
    else
      sum1 += 0;
  }

  // generate 3 flips for coin-2
  for (std::size_t i = 0; i < FLIPS; ++i) {
    // Baised Coin-2
    int temp2;
    std::string name = "temp_c2_" + std::to_string(i);
    make_pse_symbolic(&temp2, sizeof(temp2), name.c_str(), 1, LIMIT);
    tmp2[i] = temp2;
    if (temp2 >= b2)
      sum2 += 1;
    else
      sum2 += 0;
  }

  SUM = sum1 + sum2;

  /* COMMENT : KLEE ASSUMES from ANALYSIS */
  klee_assume(
      (b1 > tmp1[0] && b2 <= tmp2[0] && (SUM == 3 || SUM == 2 || SUM == 6)) ||
      (b1 <= tmp1[0] && b2 > tmp2[0] && (SUM == 1 || SUM == 5 || SUM == 4)) ||
      (b1 > tmp1[0] && b2 > tmp2[0] && (SUM == 3 || SUM == 2 || SUM == 6)) ||
      (b1 <= tmp1[0] && b2 <= tmp2[0] && (SUM == 3 || SUM == 2 || SUM == 6)));

  // klee_dump_kquery_state();
  mark_state_winning();
  expected_value("SUM_sym", SUM);

  return 0;
}
