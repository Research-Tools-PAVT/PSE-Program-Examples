#include <klee/klee.h>
#include <stdio.h>

int main(void)
{
	int c = 90, a = 90, b, d;
	float dist[] = {1, 2, 3, 4, 5, 6};
	float prob[] = {0.1, 0.4, 0.1, 0.1, 0.2, 0.1};

	klee_make_symbolic(&a, sizeof(a), "a_sym");
	klee_make_symbolic(&b, sizeof(b), "b_sym");
	klee_make_symbolic(&c, sizeof(c), "c_sym");
	klee_make_pse_symbolic(&d, sizeof(d), "d_pse_sym", dist, prob);

	if (a > b && d < a && c > a && d < b)
	{
		c *= 2;
	}
	else
	{
		if (c > 0)
		{
			printf("%d", b);
		}
		else
		{
			printf("%d", d);
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