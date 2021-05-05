// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include <assert.h>
#include <stdio.h>
#include <random>
#include <vector>
#include "PSE.h"

/**
 * @brief Set the Fraction Value object 
 * 
 * @param addr 
 * @param numerator 
 * @param denominator 
 */
void setFractionValue(void *addr, int numerator, int denominator)
{
}

int main()
{
    double choice_prob;
    int d;

    // forall variables
    make_pse_symbolic(&d, sizeof(d), "d_pse_sym", 0, 2);
    klee_make_symbolic(&choice_prob, sizeof(choice_prob), "choice_prob_sym");

    int choice_num, choice_denom;

    if (d == 0)
    {
        int choice_num, choice_denom;
        klee_make_symbolic(&choice_num, sizeof(choice_num), "choice_numerator_0");
        klee_make_symbolic(&choice_denom, sizeof(choice_denom), "choice_denominator_0");
        choice_num = 1;
        choice_denom = 50;
        klee_dump_symbolic_details(&choice_num, "choice_numerator");
        klee_dump_symbolic_details(&choice_denom, "choice_denominator");
    }
    else
    {
        int choice_num, choice_denom;
        klee_make_symbolic(&choice_num, sizeof(choice_num), "choice_numerator_1");
        klee_make_symbolic(&choice_denom, sizeof(choice_denom), "choice_denominator_1");
        choice_num = 1;
        choice_denom = 16;
        klee_dump_symbolic_details(&choice_num, "choice_numerator");
        klee_dump_symbolic_details(&choice_denom, "choice_denominator");
    }

    return 0;
}