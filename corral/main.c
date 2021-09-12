#include <assert.h>

int main(void) {

  int a = 0, b = 1000;

  while (a <= b) {
    a = a + 1;
    b = b - 1;
  }

  // This assert must fail
  // /k:1000 /recursionBound:1000 /timeLimit:50000
  assert(a > 2 * b);
}