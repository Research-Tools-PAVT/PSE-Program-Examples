#include <klee/klee.h>
#include <algorithm>
#include <string>
#include <vector>
#include <stdio.h>

template <class T>
void make_pse_symbolic(void *addr, size_t bytes, const char *name, std::vector<T> dist)
{
    klee_make_symbolic(addr, bytes, name);
    klee_assume(*(T *)addr >= *std::min_element(dist.begin(), dist.end()));
    klee_assume(*(T *)addr <= *std::max_element(dist.begin(), dist.end()));
}