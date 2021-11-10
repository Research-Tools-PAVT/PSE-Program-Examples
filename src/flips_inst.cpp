#include <PSE.h>
#define FLIPS 3

int main(int argc, char *argv[]) {

  int sum1 = 0, sum2 = 0, b1, b2, SUM, temp1arr[FLIPS], temp2arr[FLIPS];

  klee_make_symbolic(&b1, sizeof(b1), "b1_sym");
  klee_make_symbolic(&b2, sizeof(b2), "b2_sym");

  klee_make_symbolic(&SUM, sizeof(SUM), "SUM_sym");
  klee_make_symbolic(&sum1, sizeof(sum1), "sum1_sym");
  klee_make_symbolic(&sum2, sizeof(sum2), "sum2_sym");

  // generate 3 flips for coin-1
  for (std::size_t i = 0; i < FLIPS; ++i) {
    // Baised Coin-1.
    int temp1, coin_curr1;
    std::string name = "temp_c1_" + std::to_string(i);
    make_pse_symbolic(&temp1, sizeof(temp1), name.c_str(), (int)1, (int)100000);
    std::string outcome_str = "coin1_index_" + std::to_string(i);
    make_pse_symbolic(&coin_curr1, sizeof(coin_curr1), outcome_str.c_str(),
                      (int)0, (int)1);
    temp1arr[i] = temp1;
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
    make_pse_symbolic(&temp2, sizeof(temp2), name.c_str(), (int)1, (int)100000);
    std::string outcome_str = "coin2_index_" + std::to_string(i);
    make_pse_symbolic(&coin_curr2, sizeof(coin_curr2), outcome_str.c_str(),
                      (int)0, (int)1);
    temp2arr[i] = temp2;
    if (temp2 >= b2)
      coin_curr2 = 1;
    else
      coin_curr2 = 0;
    sum2 += coin_curr2;
  }

  SUM = sum1 + sum2;

  /* COMMENT : KLEE ASSUMES from ANALYSIS */
  klee_assume(((b1 > temp1arr[0] && b2 < temp2arr[0]) && (sum1 + sum2 <= 5)) ||
              ((b1 < temp1arr[0] && b2 > temp2arr[0]) && (sum1 + sum2 >= 4)));

  // klee_print_expr("Sum_1 ", sum1);
  // klee_print_expr("Sum_2 ", sum2);
  // klee_print_expr("SUM_FINAL ", SUM);
  klee_dump_kquery_state();
  mark_state_winning();
  return 0;
}
