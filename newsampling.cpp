// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include <assert.h>
#include <stdio.h>
#include <random>
#include <vector>
#include "PSE.h"

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

    (d == 1) ? setFractionValue(&choice, 1, 6, 1) : ((d == 2) ? setFractionValue(&choice, 1, 6, 2) : ((d == 3) ? setFractionValue(&choice, 1, 6, 3) : ((d == 4) ? setFractionValue(&choice, 1, 6, 4) : ((d == 5) ? setFractionValue(&choice, 1, 6, 5) : ((d == 6) ? setFractionValue(&choice, 1, 6, 6) : setFractionValue(&choice, 1, 6, 0))))));
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