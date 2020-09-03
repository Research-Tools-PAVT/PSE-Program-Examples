#include <stdio.h>
#include <assert.h>
#include <klee/klee.h>

int branch_options(int a, int b, int c)
{

   int x = 0, y = 0, z = 0;

   if (a > 0)
   {
      x = 2;
   }

   if (a > 10 && b >= 3)
   {
      x = 90;
      y = 100;
      z = -40;
   }
   else if (a < -100)
   {
      x = 80;
      z = 90;
   }
   else if (a >= 0 && c >= 50)
   {
      x = -95;
      y = -45;
   }
   else
   {
      x = 90;
      y = 100;
      z = 70;
   }

   // if (a > 0 && b > 0 && c > 0) {
   //   // Doesnot halt even after specifying low threshold?
   //    while (a > 0) {
   //       x++;
   //       --a;
   //    }
   // }

   assert(x + y > 30);
   assert(x + y + z <= 50);
   return x + y + z;
}

int main()
{
   int a, b, c;
   klee_make_symbolic(&a, sizeof(a), "a_sym");
   klee_make_symbolic(&b, sizeof(b), "b_sym");
   klee_make_symbolic(&c, sizeof(c), "c_sym");
   return branch_options(a, b, c);
}
