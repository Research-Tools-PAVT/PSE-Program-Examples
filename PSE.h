#include <klee/klee.h>
#include <algorithm>
#include <stdio.h>

/**
 * @brief Set the Fraction Value object addr to (numerator / denominator)
 * 
 * @param addr (pointer)
 * @param numerator 
 * @param denominator 
 */
void setFractionValue(void *addr, int numerator, int denominator, int index)
{
    int choice_num, choice_denom;
    std::string index_str = std::to_string(index);

    std::string numerator_str("num_");
    numerator_str += index_str;
    numerator_str += "_sym";

    std::string denom_str("denom_");
    denom_str += index_str;
    denom_str += "_sym";

    std::string setFractionPlaceholder("setFraction");
    setFractionPlaceholder += index_str;

    klee_make_symbolic(&choice_num, sizeof(choice_num), numerator_str.c_str());
    klee_make_symbolic(&choice_denom, sizeof(choice_denom), denom_str.c_str());

    choice_num = numerator;
    choice_denom = denominator;
    *(double *)addr = (double)choice_num / choice_denom;

    klee_dump_symbolic_details(&choice_num, numerator_str.c_str());
    klee_dump_symbolic_details(&choice_denom, denom_str.c_str());
    klee_dump_symbolic_details(addr, setFractionPlaceholder.c_str());
}

template <class T>
/**
 * @brief Creates a probabilistic symbolic variable.  Specify start and end of uniform distribution range. [Any order works]
 * 
 * @param addr (pointer)
 * @param bytes (size)
 * @param name 
 * @param min_elem 
 * @param max_elem 
 */
void make_pse_symbolic(void *addr, size_t bytes, const char *name, T &&min_elem, T &&max_elem)
{
    klee_make_symbolic(addr, bytes, name);
    klee_assume(*(T *)addr >= std::min(min_elem, max_elem));
    klee_assume(*(T *)addr <= std::max(min_elem, max_elem));
}