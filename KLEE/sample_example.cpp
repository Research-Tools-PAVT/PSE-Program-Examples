#include <klee/klee.h>
#include <stdio.h>
#include <assert.h>
#include <random>

std::default_random_engine generator;
std::uniform_int_distribution<int> distribution(10, 150);
    
int weird_sum_func(int a, int b, int c)
{

   // Forall Variables. 	
   int x = 0, y = 0, z = 0;

   if (a > 0)
   {
      x = 2;
   }

   if (a > 10 && b >= 3)
   {
      x = -20;
      y = distribution(generator);
      z = 100;
   }
   else if (a < 0)
   {
      x = 80;
      z = 90;
   }
   else if (a >= 0 && c >= 50)
   {
      x = distribution(generator);
      y = distribution(generator);
   }
   else
   {
      x = 80;
      y = 90;
      z = 100;
   }

   assert(x + y > 30);
   assert(x + y + z >= 50);
   
   
   return x + y + z;
}

int main(void)
{
   int a, b, c;
   
   klee_make_pse_symbolic(&a, sizeof(a), "a_pse_sym");
   klee_make_pse_symbolic(&b, sizeof(b), "b_pse_sym");
   
   a = distribution(generator);
   b = distribution(generator);
   c = distribution(generator);
   
   klee_make_symbolic(&c, sizeof(c), "c_sym");
   
   return weird_sum_func(a, b, c);
}
