#include <klee/klee.h>
#include <stdio.h>

int main(void)
{
	int a;
	int b;
	int c = 90;
	klee_make_symbolic(&a, sizeof(a), "a_sym");
	klee_make_symbolic(&b, sizeof(b), "b_sym");
	klee_make_symbolic(&c, sizeof(c), "c_sym");

	if (a > b)
	{
		c *= 9;
	}
	else
	{
		if (c > 0)
		{
			printf("%d", b);
		}
		else
		{
			printf("%d", a);
		}
	}

	if (a > c)
	{
		b *= 8;
		c *= 2;
	}
	else
	{
		a *= 2;
		b *= 3;
		c *= 4;
	}

	return 0;
}