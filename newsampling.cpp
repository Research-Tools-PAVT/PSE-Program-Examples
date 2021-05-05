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
void setFractionValue(void *addr, int numerator, int denominator, int index)
{
    int choice_num, choice_denom;

    std::string numerator_str("num_");
    numerator_str += std::to_string(index);
    numerator_str += "_sym";

    std::string denom_str("denom_");
    denom_str += std::to_string(index);
    denom_str += "_sym";

    klee_make_symbolic(&choice_num, sizeof(choice_num), numerator_str.c_str());
    klee_make_symbolic(&choice_denom, sizeof(choice_denom), denom_str.c_str());

    choice_num = numerator;
    choice_denom = denominator;
    *(double *)addr = (double)choice_num / choice_denom;

    klee_dump_symbolic_details(&choice_num, numerator_str.c_str());
    klee_dump_symbolic_details(&choice_denom, denom_str.c_str());
    klee_dump_symbolic_details(addr, "choice_value");
}

int main()
{
    int d, value_d;
    double choice;

    make_pse_symbolic(&d, sizeof(d), "d_sym", 0, 6);
    klee_make_symbolic(&value_d, sizeof(value_d), "value_d");
    klee_make_symbolic(&choice, sizeof(choice), "choice_sym");

    std::default_random_engine generator;
    std::uniform_int_distribution<int> int_distribution(1, 6);
    d = int_distribution(generator);
    klee_dump_kquery_state();

    value_d = d;
    // COMMENT : Evaluates to true so can't get symbolic expression.
    klee_assume(value_d == d);

    klee_dump_symbolic_details(&d, "d_sym");

    (d == 1) ? setFractionValue(&choice, 1, 6, d) : ((d == 2) ? setFractionValue(&choice, 1, 6, d) : ((d == 3) ? setFractionValue(&choice, 1, 6, d) : ((d == 4) ? setFractionValue(&choice, 1, 6, d) : ((d == 5) ? setFractionValue(&choice, 1, 6, d) : ((d == 6) ? setFractionValue(&choice, 1, 6, d) : setFractionValue(&choice, 1, 6, d))))));
    klee_dump_kquery_state();
}

// (d == 1) ?
//     setFractionValue(&choice, 1, 6) :
//     ((d == 2) ?
//         setFractionValue(&choice, 1, 6) :
//             ((d == 3) ?
//                 setFractionValue(&choice, 1, 6) :
//                     ((d == 4) ?
//                         setFractionValue(&choice, 1, 6) :
//                         ((d == 5) ?
//                             setFractionValue(&choice, 1, 6) :
//                             ((d == 6) ?
//                                 setFractionValue(&choice, 1, 6) : setFractionValue(&choice, 1, 6))))));