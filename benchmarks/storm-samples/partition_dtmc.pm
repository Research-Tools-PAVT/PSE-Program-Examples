dtmc

module pivot

	// local state
	s : [0..11] init 0;

	// value of the 10-sided dice 
    // dice value == pivot index
	pivot : [1..10] init 1;
    
    // Max Return, max(#left, #right)
    maxval : [4..9] init 4;
	
	[flip1] s=0 -> 0.5 : (s'=1);
	[flip2] s=0 -> 0.5 : (s'=2);
	[flip3] s=1 -> 0.5 : (s'=3) + 0.5 : (s'=4);
	[flip4] s=2 -> 0.5 : (s'=5) + 0.5 : (s'=6);
    [flip5] s=3 -> 0.5 : (s'=7) + 0.5 : (s'=8);
    [flip6] s=7 -> 0.5 : (s'=11) & (pivot'=1) & (maxval'=9) + 0.5 : (maxval'=8) & (pivot'=2) & (s'=11);
    [flip7] s=8 -> 0.5 : (s'=11) & (pivot'=3) & (maxval'=7) + 0.5 : (maxval'=6) & (pivot'=4) & (s'=11);
    [flip8] s=4 -> 0.5 : (s'=11) & (pivot'=5) & (maxval'=5) + 0.5 : (maxval'=5) & (pivot'=6) & (s'=11);
    [flip9] s=5 -> 0.5 : (s'=11) & (pivot'=7) & (maxval'=6) + 0.5 : (maxval'=7) & (pivot'=8) & (s'=11);
    [flip10] s=6 -> 0.5 : (s'=11) & (pivot'=9) & (maxval'=8) + 0.5 : (maxval'=9) & (pivot'=10) & (s'=11);

    [end] s=11 -> (s'=11);


endmodule

rewards "pivot_reach"
	[] s<11 : 1;
endrewards

rewards "maxval_reach"
	[] maxval<9 : 1;
endrewards