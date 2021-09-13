#include <assert.h>
#include <stdio.h>

int main(void) {

  int a = __VERIFIER_nondet_uint() % 100000000,
      b = __VERIFIER_nondet_uint() % 100000000;

  while (a <= b) {
    printf("\nLoop Start : %s : %d, %s, %d", "a", a, "b", b);
    a = a + 1;
    b = b - 1;
    printf("Loop End : %s : %d, %s, %d", "a", a, "b", b);
    // assert(a > b);
  }

  // This assert must fail
  // /k:700 /recursionBound:700 /timeLimit:50000
  assert(a < b - 1);
}