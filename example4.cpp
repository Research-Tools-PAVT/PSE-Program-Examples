#include <assert.h>
#include <klee/klee.h>
#include <random>
#include <stdio.h>

int main (void) {
	int a = 17;
	klee_make_symbolic(&a, sizeof(a), "a_pse_sym");
	
	if (a > a - 1 && a < a + 1 && a != 10 && a != a * 2) {
		a = 10;
	} else {
		a = 90;
	}

	if (a < 50 && a >= 60) {
		a = 50;
	} else {
		a = 30;
	}

	if (a > 5 && a < 70) {
		a = 89;
	} else {
		a = 78;
	}
}