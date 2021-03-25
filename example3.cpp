// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions -emit-llvm -c -o %t1.bc %s
// RUN: rm -rf %t.klee-out
// RUN: %klee --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests --exit-on-error --optimize --disable-inlining --search=nurs:depth --use-cex-cache %t1.bc

#include <assert.h>
#include <stdio.h>
#include <vector>
#include "PSE.h"

int vector_to_int(std::vector<int> v)
{
    reverse(v.begin(), v.end());
    int decimal = 1;
    int total = 0;
    for (auto &it : v)
    {
        total += it * decimal;
        decimal *= 10;
    }
    return total;
}

void reservoir_sample(std::vector<int> &input, std::vector<int> &sample, int n, int k)
{
    for (int i = 0; i < k; i++)
    {
        sample[i] = input[i];
    }

    for (int i = k; i < n; i++)
    {
        int j;

        make_pse_symbolic(&j, sizeof(j), "j_sym", 0, (int)i);

        if (j < k)
        {
            sample[j] = input[i];
        }
    }
}

int main()
{
    int n = 10;
    std::vector<int> arr(n);
    for (size_t i = 0; i < n; i++)
    {
        arr[i] = i + 1;
    }
    int k;
    klee_make_symbolic(&k, sizeof(k), "k_sym");
    klee_assume(k >= 1 && k <= 10);

    std::vector<int> sample(k);
    reservoir_sample(arr, sample, n, k);

    std::sort(sample.begin(), sample.end());
    return vector_to_int(sample);
}
