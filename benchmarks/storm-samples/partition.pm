dtmc

const int N = 10;
const choice_prob = 1/N;

module main

    left : [0..N-1];
    right : [0..N-1];
    pivot : [0..N];

    [piv1] pivot=0 & left=0 & right=0 -> 0.1 : (pivot'=1) & (left'=0) & (right'=N-1);
    [piv2] pivot=0 & left=0 & right=0 -> 0.1 : (pivot'=2) & (left'=1) & (right'=N-2);
    [piv3] pivot=0 & left=0 & right=0 -> 0.1 : (pivot'=3) & (left'=2) & (right'=N-3);
    [piv4] pivot=0 & left=0 & right=0 -> 0.1 : (pivot'=4) & (left'=3) & (right'=N-4);
    [piv5] pivot=0 & left=0 & right=0 -> 0.1 : (pivot'=5) & (left'=4) & (right'=N-5);
    [piv6] pivot=0 & left=0 & right=0 -> 0.1 : (pivot'=6) & (left'=5) & (right'=N-6);
    [piv7] pivot=0 & left=0 & right=0 -> 0.1 : (pivot'=7) & (left'=6) & (right'=N-7);
    [piv8] pivot=0 & left=0 & right=0 -> 0.2 : (pivot'=8) & (left'=7) & (right'=N-8);
    [piv9] pivot=0 & left=0 & right=0 -> 0.05 : (pivot'=9) & (left'=8) & (right'=N-9);
    [piv10] pivot=0 & left=0 & right=0 -> 0.05 : (pivot'=10) & (left'=9) & (right'=N-10);

    [completed] (pivot>0) -> true;

endmodule

init pivot=0&left=0&right=0  endinit

label "state1" = pivot=2;
label "state2" = right=3;

rewards "pivot"
	[completed] pivot>0 : 0.5;
endrewards