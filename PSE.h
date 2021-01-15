#include <klee/klee.h>
#include <algorithm>
#include <stdio.h>

/// COMMENT : Specify start and end of uniform distribution range. [Any order works]
template <class T>
void make_pse_symbolic(void *addr, size_t bytes, const char *name, T &&min_elem, T &&max_elem)
{
    klee_make_symbolic(addr, bytes, name);
    klee_assume(*(T *)addr >= std::min(min_elem, max_elem));
    klee_assume(*(T *)addr <= std::max(min_elem, max_elem));
}