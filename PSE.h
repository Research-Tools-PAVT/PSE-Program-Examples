#include <klee/klee.h>
#include <algorithm>
#include <string>
#include <vector>
#include <stdio.h>

template <class T>
std::string tostring(std::vector<T> &vec)
{
    std::string str("");
    for (const auto &elems : vec)
    {
        str.append(std::to_string(elems));
        str.append(",");
    }
    str.pop_back();
    return str;
}

template <class T>
void make_pse_symbolic(void *addr, size_t bytes, const char *name, std::vector<T> dist)
{
    klee_make_symbolic(addr, bytes, name);
    klee_assume(*(T *)addr >= *std::min_element(dist.begin(), dist.end()));
    klee_assume(*(T *)addr <= *std::max_element(dist.begin(), dist.end()));
}