#include <iostream>
#include <assert.h>

float __start(int n, int y) {
	int flips_needed = n;
	/**
	* Code to use the forall values. 
	* Sample value of the probabilistic variable.
	* return the the probability mass
	*
	* Check for threshold. 
	* Check for distinct probability paths. 
	*/
	return 0.005f;
}

int main(void) {
	
	// BMC will produce only one path unlike
	// multiple paths that KLEE (SymbEx produces)
	long long int sum = 0LL;
	int n = 10, y = 90;
	float prob_weight = 0.80f, sum_prob = 0.00f, prob = 0.585f;

	while (sum_prob <= prob_weight) {
		printf("Sum Prob : %lf \n", sum_prob);
		sum_prob += __start(n, y);
	}

	// BMC tries to fail this.
	assert(n * sum_prob * y > 10 * y);
	
	return 0;
}
