#include <klee/klee.h>
#include <stdio.h>
#include <assert.h>
#include <random>

std::default_random_engine generator;
std::uniform_int_distribution<int> distribution(10, 150);
    
int weird_func(int a, int b, int c)
{
   if (a > b + c) {
      return a + b + c;
      klee_dump_kquery_var();
   } else {
      return a - b - c;
   }
}

int main(void)
{
   int a, b, c;
   
   float _distribution1[] = {1, 2, 3, 4, 5, 6};
   float _probabilities1[] = {0.1, 0.1, 0.2, 0.3, 0.1, 0.2};

   float _distribution2[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
   float _probabilities2[] = {0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1};
   
   klee_make_pse_symbolic(&a, sizeof(a), "a_pse_sym", _distribution1, _probabilities1);
   klee_make_pse_symbolic(&b, sizeof(b), "b_pse_sym", _distribution2, _probabilities2);
   
   a = _distribution1[2];        // PSE Variable
   b = _distribution2[3];        // PSE Variable
   c = distribution(generator);  // ForAll Variable
   
   klee_make_symbolic(&c, sizeof(c), "c_sym");
   return weird_func(a, b, c);
}
