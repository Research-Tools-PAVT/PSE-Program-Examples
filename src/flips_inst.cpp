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
  int b1 = 10, b2 = 10, SUM = 0;
  double bias1 = 0.0000;
  double bias2 = 0.0000;

  int coin1[3], coin2[3], sum1, sum2;

  klee_make_symbolic(&b1, sizeof(b1), "b1_sym");
  klee_make_symbolic(&b2, sizeof(b2), "b2_sym");

  klee_make_symbolic(&SUM, sizeof(SUM), "SUM_sym");
  make_pse_symbolic(coin1, sizeof(coin1), "coin1_arr_sym", (int)0, int(1));
  make_pse_symbolic(coin2, sizeof(coin2), "coin2_arr_sym", (int)0, int(1));

  klee_make_symbolic(&sum1, sizeof(sum1), "sum1_sym");
  klee_make_symbolic(&sum2, sizeof(sum2), "sum2_sym");

  /* Instrumented Assume Forall : f2 CLASS */
  klee_assume(b1 >= 1 && b1 <= 49999);
  klee_assume(b2 >= 70000 && b2 <= 100000);

  /* Instrumented Assume Forall : B1, B3 Prob CLASS */
  klee_assume((sum1 + sum2 == 0) || (sum1 + sum2 == 1) || (sum1 + sum2 == 2) ||
              (sum1 + sum2 == 5));

  bias1 = (double)(b1) / 100000;
  bias2 = (double)(b2) / 100000;

  // std::bernoulli_distribution d1(bias1);
  // std::bernoulli_distribution d2(bias2);

  // generate 3 flips for coin-1
  for (std::size_t i = 0; i < FLIPS; ++i) {
    // Uncomment if KLEE not allowed to pick
    // coin1[i] = rand() > bias1 ? 1 : 0;
    sum1 += coin1[i];
    klee_print_expr("Sum_1 = ", sum1);
  }

  // generate 3 flips for coin-2
  for (std::size_t i = 0; i < FLIPS; ++i) {
    // Uncomment if KLEE not allowed to pick
    // coin2[i] = rand() > bias2 ? 1 : 0;
    sum2 += coin2[i];
    klee_print_expr("Sum_2 = ", sum2);
  }

  SUM = sum1 + sum2;
  klee_print_expr("SUM_FINAL = ", SUM);

  return 0;
}

/*
ENCODING : When KLEE is allowed to sample.
Sum_1 = :(Add w32 (ReadLSB w32 0 sum1_sym)
          (ReadLSB w32 0 coin1_arr_sym))
Sum_1 = :(Add w32 (ReadLSB w32 0 sum1_sym)
          (ReadLSB w32 0 coin1_arr_sym))
Sum_1 = :(Add w32 (Add w32 (ReadLSB w32 0 sum1_sym)
                   (ReadLSB w32 0 coin1_arr_sym))
          (ReadLSB w32 4 coin1_arr_sym))
Sum_1 = :(Add w32 (Add w32 (ReadLSB w32 0 sum1_sym)
                   (ReadLSB w32 0 coin1_arr_sym))
          (ReadLSB w32 4 coin1_arr_sym))
Sum_1 = :(Add w32 (Add w32 (Add w32 (ReadLSB w32 0 sum1_sym)
                            (ReadLSB w32 0 coin1_arr_sym))
                   (ReadLSB w32 4 coin1_arr_sym))
          (ReadLSB w32 8 coin1_arr_sym))
Sum_1 = :(Add w32 (Add w32 (Add w32 (ReadLSB w32 0 sum1_sym)
                            (ReadLSB w32 0 coin1_arr_sym))
                   (ReadLSB w32 4 coin1_arr_sym))
          (ReadLSB w32 8 coin1_arr_sym))
Sum_1 = :(Add w32 (ReadLSB w32 0 sum1_sym)
          (ReadLSB w32 0 coin1_arr_sym))
Sum_2 = :(Add w32 (ReadLSB w32 0 sum2_sym)
          (ReadLSB w32 0 coin2_arr_sym))
Sum_2 = :(Add w32 (Add w32 (ReadLSB w32 0 sum2_sym)
                   (ReadLSB w32 0 coin2_arr_sym))
          (ReadLSB w32 4 coin2_arr_sym))
Sum_2 = :(Add w32 (ReadLSB w32 0 sum2_sym)
          (ReadLSB w32 0 coin2_arr_sym))
Sum_1 = :(Add w32 (Add w32 (ReadLSB w32 0 sum1_sym)
                   (ReadLSB w32 0 coin1_arr_sym))
          (ReadLSB w32 4 coin1_arr_sym))
Sum_2 = :(Add w32 (Add w32 (Add w32 (ReadLSB w32 0 sum2_sym)
                            (ReadLSB w32 0 coin2_arr_sym))
                   (ReadLSB w32 4 coin2_arr_sym))
          (ReadLSB w32 8 coin2_arr_sym))
Sum_2 = :(Add w32 (Add w32 (ReadLSB w32 0 sum2_sym)
                   (ReadLSB w32 0 coin2_arr_sym))
          (ReadLSB w32 4 coin2_arr_sym))
SUM_FINAL = :(Add w32 (Add w32 (Add w32 (Add w32 (ReadLSB w32 0 sum1_sym)
                                     (ReadLSB w32 0 coin1_arr_sym))
                            (ReadLSB w32 4 coin1_arr_sym))
                   (ReadLSB w32 8 coin1_arr_sym))
          (Add w32 (Add w32 (Add w32 (ReadLSB w32 0 sum2_sym)
                                     (ReadLSB w32 0 coin2_arr_sym))
                            (ReadLSB w32 4 coin2_arr_sym))
                   (ReadLSB w32 8 coin2_arr_sym)))



Sum_2 = :(Add w32 (Add w32 (Add w32 (ReadLSB w32 0 sum2_sym)
                            (ReadLSB w32 0 coin2_arr_sym))
                   (ReadLSB w32 4 coin2_arr_sym))
          (ReadLSB w32 8 coin2_arr_sym))
Sum_1 = :(Add w32 (Add w32 (Add w32 (ReadLSB w32 0 sum1_sym)
                            (ReadLSB w32 0 coin1_arr_sym))
                   (ReadLSB w32 4 coin1_arr_sym))
          (ReadLSB w32 8 coin1_arr_sym))
SUM_FINAL = :(Add w32 (Add w32 (Add w32 (Add w32 (ReadLSB w32 0 sum1_sym)
                                     (ReadLSB w32 0 coin1_arr_sym))
                            (ReadLSB w32 4 coin1_arr_sym))
                   (ReadLSB w32 8 coin1_arr_sym))
          (Add w32 (Add w32 (Add w32 (ReadLSB w32 0 sum2_sym)
                                     (ReadLSB w32 0 coin2_arr_sym))
                            (ReadLSB w32 4 coin2_arr_sym))
                   (ReadLSB w32 8 coin2_arr_sym)))
Sum_2 = :(Add w32 (ReadLSB w32 0 sum2_sym)
          (ReadLSB w32 0 coin2_arr_sym))
Sum_2 = :(Add w32 (Add w32 (ReadLSB w32 0 sum2_sym)
                   (ReadLSB w32 0 coin2_arr_sym))
          (ReadLSB w32 4 coin2_arr_sym))
Sum_2 = :(Add w32 (Add w32 (Add w32 (ReadLSB w32 0 sum2_sym)
                            (ReadLSB w32 0 coin2_arr_sym))
                   (ReadLSB w32 4 coin2_arr_sym))
          (ReadLSB w32 8 coin2_arr_sym))
SUM_FINAL = :(Add w32 (Add w32 (Add w32 (Add w32 (ReadLSB w32 0 sum1_sym)
                                     (ReadLSB w32 0 coin1_arr_sym))
                            (ReadLSB w32 4 coin1_arr_sym))
                   (ReadLSB w32 8 coin1_arr_sym))
          (Add w32 (Add w32 (Add w32 (ReadLSB w32 0 sum2_sym)
                                     (ReadLSB w32 0 coin2_arr_sym))
                            (ReadLSB w32 4 coin2_arr_sym))
                   (ReadLSB w32 8 coin2_arr_sym)))
Sum_1 = :(Add w32 (ReadLSB w32 0 sum1_sym)
          (ReadLSB w32 0 coin1_arr_sym))
Sum_1 = :(Add w32 (Add w32 (ReadLSB w32 0 sum1_sym)
                   (ReadLSB w32 0 coin1_arr_sym))
          (ReadLSB w32 4 coin1_arr_sym))
Sum_1 = :(Add w32 (Add w32 (Add w32 (ReadLSB w32 0 sum1_sym)
                            (ReadLSB w32 0 coin1_arr_sym))
                   (ReadLSB w32 4 coin1_arr_sym))
          (ReadLSB w32 8 coin1_arr_sym))
Sum_2 = :(Add w32 (ReadLSB w32 0 sum2_sym)
          (ReadLSB w32 0 coin2_arr_sym))
Sum_2 = :(Add w32 (Add w32 (ReadLSB w32 0 sum2_sym)
                   (ReadLSB w32 0 coin2_arr_sym))
          (ReadLSB w32 4 coin2_arr_sym))
Sum_2 = :(Add w32 (Add w32 (Add w32 (ReadLSB w32 0 sum2_sym)
                            (ReadLSB w32 0 coin2_arr_sym))
                   (ReadLSB w32 4 coin2_arr_sym))
          (ReadLSB w32 8 coin2_arr_sym))
SUM_FINAL = :(Add w32 (Add w32 (Add w32 (Add w32 (ReadLSB w32 0 sum1_sym)
                                     (ReadLSB w32 0 coin1_arr_sym))
                            (ReadLSB w32 4 coin1_arr_sym))
                   (ReadLSB w32 8 coin1_arr_sym))
          (Add w32 (Add w32 (Add w32 (ReadLSB w32 0 sum2_sym)
                                     (ReadLSB w32 0 coin2_arr_sym))
                            (ReadLSB w32 4 coin2_arr_sym))
                   (ReadLSB w32 8 coin2_arr_sym)))
*/