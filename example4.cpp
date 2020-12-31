#include <assert.h>
#include <klee/klee.h>
#include <random>
#include <stdio.h>

int main (void) {
	int a;
	klee_make_symbolic(&a, sizeof(a), "a_pse_sym");
	if (a > a - 1 && a < a + 1 && a != 10 && a != a * 2) {
		a = 10;
	} else {
		a = 90;
	}
}