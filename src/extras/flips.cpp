#include <PSE.h>
#include <klee/klee.h>
#include <stdio.h>
#define FLIPS 3
#define LIMIT 10000

int main(int argc, char *argv[]) {

  int sum1 = 0, sum2 = 0, b1, b2, SUM, tmp1[FLIPS], tmp2[FLIPS];

  klee_make_symbolic(&b1, sizeof(b1), "b1_sym");
  klee_make_symbolic(&b2, sizeof(b2), "b2_sym");
  klee_assume(b1 >= 1 && b1 <= LIMIT);
  klee_assume(b2 >= 1 && b2 <= LIMIT);

  make_pse_symbolic(&SUM, sizeof(SUM), "SUM_sym", 0, 4);
  SUM = 0;
  // klee_make_symbolic(&sum1, sizeof(sum1), "sum1_sym");
  // klee_make_symbolic(&sum2, sizeof(sum2), "sum2_sym");

  // generate 3 flips for coin-1
  for (std::size_t i = 0; i < FLIPS; ++i) {
    // Baised Coin-1.
    int temp1, coin_curr1;
    std::string name = "temp_c1_" + std::to_string(i);
    klee_make_symbolic(&temp1, sizeof(temp1), name.c_str());
    klee_assume(temp1 >= 1 && temp1 <= LIMIT);
    klee_assume(temp1 >= 1 && temp1 <= LIMIT);
    // std::string outcome_str = "coin1_index_" + std::to_string(i);
    // make_pse_symbolic(&coin_curr1, sizeof(coin_curr1), outcome_str.c_str(),
    //                   (int)0, (int)1);
    tmp1[i] = temp1;
    if (temp1 >= b1)
      coin_curr1 = 1;
    else
      coin_curr1 = 0;
    sum1 += coin_curr1;
  }

  // generate 3 flips for coin-2
  for (std::size_t i = 0; i < FLIPS; ++i) {
    // Baised Coin-2
    int temp2, coin_curr2;
    std::string name = "temp_c2_" + std::to_string(i);
    klee_make_symbolic(&temp2, sizeof(temp2), name.c_str());
    klee_assume(temp2 >= 1 && temp2 <= LIMIT);
    klee_assume(temp2 >= 1 && temp2 <= LIMIT);
    // std::string outcome_str = "coin2_index_" + std::to_string(i);
    // make_pse_symbolic(&coin_curr2, sizeof(coin_curr2), outcome_str.c_str(),
    //                   (int)0, (int)1);
    tmp2[i] = temp2;
    if (temp2 >= b2)
      coin_curr2 = 1;
    else
      coin_curr2 = 0;
    sum2 += coin_curr2;
  }

  SUM = sum1 + sum2;

  // printf("SUM %d", SUM);
  klee_print_expr("SUM", SUM);
  klee_dump_kquery_state();
  mark_state_winning();
  expected_value("SUM_sym", SUM);

  return 0;
}
