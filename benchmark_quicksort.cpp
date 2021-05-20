// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include "PSE.h"
#include <assert.h>
#include <random>

#define SIZE 5
int count = 0, counter = 0, swap_count = 0;

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

void swap(int &a, int &b)
{
    int temp = a;
    a = b;
    b = temp;
}

int partition(int arr[], int left, int right)
{
    // pivot element
    int pivot = arr[right];
    int i = (left - 1);

    /**
     * @brief We need to extract count as a 
     * symbolic expression in the comparision.
     */

    int r = 0;

    for (int j = left; j <= right - 1; j++)
    {
        /**
         * @brief 
         * When we compare with the pivot
         * we need to increase the count so 
         * that the expression matches the 
         * E[comparisions] for later computation.
         */

        counter += 1;
        auto klm = std::to_string(counter);

        // COMMENT : Symbolic Expression for compare count.
        std::string c_symbolic("count_");
        c_symbolic += std::to_string(counter);
        c_symbolic += "_sym";
        klee_make_symbolic(&count, sizeof(count), c_symbolic.c_str());

        // COMMENT : Symbolic Expression for swap count.
        std::string swap_symbolic("swap_");
        swap_symbolic += std::to_string(counter);
        swap_symbolic += "_sym";
        klee_make_symbolic(&swap_count, sizeof(swap_count), swap_symbolic.c_str());

        // COMMENT : Symbolic Expression for count.
        std::string pivot_symbolic("pivot_");
        pivot_symbolic += std::to_string(counter);
        pivot_symbolic += "_sym";
        klee_make_symbolic(&pivot, sizeof(pivot), pivot_symbolic.c_str());

        swap_count += (arr[j] <= pivot) ? 1 : 0;

        // COMMENT : Symbolic Expression for "r".
        std::string r_str("right_partition");
        klee_make_symbolic(&r, sizeof(r), r_str.c_str());

        pivot = arr[right];
        count += (j <= (r - 1)) ? 1 : 0;

        r = right;

        if (arr[j] <= pivot)
        {
            i += 1;
            swap(arr[i], arr[j]);
        }

        klee_dump_symbolic_details(&swap_count, swap_symbolic.c_str());
        klee_dump_symbolic_details(&count, c_symbolic.c_str());
        klee_dump_symbolic_details(&pivot, pivot_symbolic.c_str());
        klee_dump_symbolic_details(&r, r_str.c_str());
    }

    swap(arr[i + 1], arr[right]);
    return (i + 1);
}

int partition_random(int arr[], int left, int right)
{
    /**
     * @brief Construct a new srand object
     * for random. Choose pivot and 
     * continue to partition sub-routine.
     */

    srand(time(NULL));
    int random = left + rand() % abs(right - left);

    // Just a choice? Hoare Partition Scheme?
    swap(arr[random], arr[right]);
    return partition(arr, left, right);
}

void quicksort_arr(int arr[], int left, int right)
{
    if (left < right)
    {
        /**
         * @brief Generate a pivot and return the
         * array with pivot placed in the correct position.
         */
        int pivot = partition_random(arr, left, right);
        quicksort_arr(arr, left, pivot - 1);
        quicksort_arr(arr, pivot + 1, right);
    }
}

int main()
{
    int arr[SIZE];

    klee_make_symbolic(arr, sizeof(arr), "arr_symbolic");
    srand(time(NULL));

    // COMMENT : case : Concretized Array.
    // Static Array else blow-up n!.
    for (auto i = 0; i < SIZE; i++)
        arr[i] = 0 + rand() % (100);

    // COMMENT : case : Symbolic Array with range.
    // for (auto i = 0; i < SIZE; i++)
    //     klee_assume(arr[i] <= 10 && arr[i] >= 0);

    quicksort_arr(arr, 0, SIZE - 1);

    return 0;
}
