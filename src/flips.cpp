#include <PSE.h>
#include <random>
#include <time.h>
#define FLIPS 3

int main(int argc, char *argv[]) {

  std::random_device rd{};
  std::mt19937 rng{rd()};
  srand(time(NULL));

  /*
    Forall Variables.
  */
  int b1, b2, SUM;
  double bias1;
  double bias2;

  int coin1[3], coin2[3], sum1 = 0, sum2 = 0;

  klee_make_symbolic(&b1, sizeof(b1), "b1_sym");
  klee_make_symbolic(&b2, sizeof(b2), "b2_sym");

  // make_pse_symbolic(coin1, sizeof(coin1), "coin1_arr_sym", (int)0, int(1));
  // make_pse_symbolic(coin2, sizeof(coin2), "coin2_arr_sym", (int)0, int(1));

  klee_make_symbolic(&SUM, sizeof(SUM), "SUM_sym");
  klee_make_symbolic(&sum1, sizeof(sum1), "sum1_sym");
  klee_make_symbolic(&sum2, sizeof(sum2), "sum2_sym");

  /* COMMENT : KLEE ASSUMES from ANALYSIS */
  // klee_assume(b1 >= 1 && b1 <= 100000);
  // klee_assume(b2 >= 1 && b2 <= 100000);

  // generate 3 flips for coin-1
  for (std::size_t i = 0; i < FLIPS; ++i) {
    // Baised Coin-1.
    if (rand() % 100000 >= b1)
      coin1[i] = 1;
    else
      coin1[i] = 0;
    sum1 += coin1[i];
  }

  // generate 3 flips for coin-2
  for (std::size_t i = 0; i < FLIPS; ++i) {
    // Baised Coin-2
    if (rand() % 100000 >= b2)
      coin2[i] = 1;
    else
      coin2[i] = 0;
    sum2 += coin2[i];
  }

  SUM = sum1 + sum2;

  klee_print_expr("Sum_1 ", sum1);
  klee_print_expr("Sum_2 ", sum2);
  klee_print_expr("SUM_FINAL ", SUM);

  return 0;
}