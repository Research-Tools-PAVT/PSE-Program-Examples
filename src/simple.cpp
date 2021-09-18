#include <PSE.h>
#include <iostream>
#include <klee/klee.h>
#include <stdio.h>

int main() {
  int a, b;

  make_pse_symbolic(&a, sizeof(a), "a", 0, 1500);
  make_pse_symbolic(&b, sizeof(b), "b", 0, 1500);

  if (a > b) {
    a = a + 1;
  } else {
    if (a < b - 1) {
      b = b - 5;
    } else {
      a = a + 10;
    }
  }
  return 0;
}