// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include "PSE.h"
#include <assert.h>
#include <random>

/**
 * @brief Initial Specs
 * Create an array of static size, say 5 elements. 
 * The elements of the array will be forall symbolic variables. 
 * The pivot will be a probabilistic symbolic variable.
 * 
 * Must not branch on the SWAP operation after PIVOT selection. 
 * Convert to ITEs.
 * 
 * analyze the expected number of comparisons in Randomized Quicksort
 * optimize on getting the maximum expected number of comparisons
 * E[count] = n * log(n) for any given random run. 
 */

#define SIZE 4
int count = 0, counter = 0, swap_count = 0;

// void swap(int &a, int &b)
// {
//     int temp = a;
//     a = b;
//     b = temp;
// }

int partition(int arr[], int left, int right)
{
    // pivot element
    int pivot, r, i = left - 1;

    int beta[SIZE];
    klee_make_symbolic(beta, sizeof(beta), "beta_sym");

    srand(time(NULL));
    int random = left + rand() % abs(right - left);

    beta[right] = arr[random];
    swap_count += 1;

    /**
     * @brief We need to extract count as a 
     * symbolic expression in the comparision.
     */

    auto __counter = std::to_string(counter++);

    // COMMENT : Symbolic Expression for compare count.
    std::string c_symbolic("count_");
    c_symbolic += __counter;
    c_symbolic += "_sym";
    klee_make_symbolic(&count, sizeof(count), c_symbolic.c_str());

    // COMMENT : Symbolic Expression for swap count.
    std::string swap_symbolic("swap_");
    swap_symbolic += __counter;
    swap_symbolic += "_sym";
    klee_make_symbolic(&swap_count, sizeof(swap_count), swap_symbolic.c_str());

    // COMMENT : Symbolic Expression for "r".
    std::string r_symbolic("r_");
    r_symbolic += __counter;
    r_symbolic += "_sym";
    klee_make_symbolic(&r, sizeof(r), r_symbolic.c_str());

    std::string pivot_symbolic("pivot_");
    pivot_symbolic += __counter;
    pivot_symbolic += "_sym";
    klee_make_symbolic(&pivot, sizeof(pivot), pivot_symbolic.c_str());

    klee_assume(pivot == beta[right]);
    klee_assume(r == right);

    for (int j = left; j <= right - 1; j++)
    {
        /**
         * @brief 
         * When we compare with the pivot
         * we need to increase the count so 
         * that the expression matches the 
         * E[comparisions] for later computation.
         * E[count] ~ n * log(n) ;
         */

        count += 1;

        // COMMENT : Fork Location.
        if (arr[j] <= pivot)
        {
            klee_assume(beta[++i] == arr[j]);
            swap_count += 1;
        }
    }

    beta[i + 1] = arr[right];
    swap_count += 1;

    klee_dump_symbolic_details(&swap_count, swap_symbolic.c_str());
    klee_dump_symbolic_details(&count, c_symbolic.c_str());
    klee_dump_symbolic_details(&r, r_symbolic.c_str());
    klee_dump_symbolic_details(&pivot, pivot_symbolic.c_str());

    return (i + 1);
}

void quicksort_arr(int arr[], int left, int right)
{
    if (left < right)
    {
        /**
         * @brief Generate a pivot and return the
         * array with pivot placed in the correct position.
         */
        // COMMENT : Symbolic Expression for pivot.
        int pivot = partition(arr, left, right);
        quicksort_arr(arr, left, pivot - 1);
        quicksort_arr(arr, pivot + 1, right);
    }
}

int concrete[] = {2, 28, 95, 96, 47, 10, 12, 3, 36, 58};

int main()
{
    srand(time(NULL));

    int arr[SIZE];
    klee_make_symbolic(arr, sizeof(arr), "alpha_sym");

    // for (auto i = 0; i < SIZE; i++)
    //     arr[i] = concrete[i];

    quicksort_arr(arr, 0, SIZE - 1);

    return 0;
}
