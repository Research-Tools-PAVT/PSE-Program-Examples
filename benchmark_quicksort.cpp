// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include "PSE.h"
#include <assert.h>
#include <random>

/**
 * @brief Quick Sort Example
 * analyze the expected number of comparisons in Randomized Quicksort
 * optimize on getting the maximum expected number of comparisons
 */

/**
 * @brief Initial Specs
 * Create an array of static size, say 5 elements. 
 * The elements of the array will be forall symbolic variables. 
 * The pivot will be a probabilistic symbolic variable.
 * 
 * Must not branch on the SWAP operation after PIVOT selection. 
 * Convert to ITEs.
 */

int main()
{
    // klee_make_symbolic(&prob, sizeof(prob), "prob_sym");
    // std::default_random_engine generator;
    // std::bernoulli_distribution bernoulli_rvs(prob);
    // std::string c_symbolic("choice_");
    // c_symbolic += std::to_string(k);
    // c_symbolic += "_sym";
}
