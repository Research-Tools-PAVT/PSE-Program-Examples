dtmc

// Set upper bound for the elements of the array
const int N = 10000;

module partiton

    arr1 : [1..N];
    arr2 : [1..N];
    arr3 : [1..N];
    arr4 : [1..N];
    arr5 : [1..N];
    pivot : [-1..N];
    state : [0..16];

    value1 : [-1..1];
    value2 : [-1..1];
    value3 : [-1..1];
    value4 : [-1..1];
    value5 : [-1..1];

    [] pivot=-1 -> 1/5 : (pivot'=arr1) + 1/5 : (pivot'=arr2) + 1/5 : (pivot'=arr3) + 1/5 : (pivot'=arr4) + 1/5 : (pivot'=arr5);

    [] pivot>arr1 -> (state'=2);
    [] pivot<=arr1 -> (state'=3);
    [] pivot>arr2 -> (state'=4);
    [] pivot<=arr2 -> (state'=5);
    [] pivot>arr3 -> (state'=6);
    [] pivot<=arr3 -> (state'=7);
    [] pivot>arr4 -> (state'=8);
    [] pivot<=arr4 -> (state'=9);
    [] pivot>arr5 -> (state'=10);
    [] pivot<=arr5 -> (state'=11);

    [] pivot>=0 & state=0 -> (state'=1) & (value1'=-1);

    [] state=1 & value1=-1 -> 0.5 : (state'=2) & (value1'=1) + 0.5 : (state'=3) & (value1'=0);
    [] state=2 & pivot>arr1 & value1=1 -> (state'=12) & (value2'=-1); // Sync State (s=2)
    [] state=3 & pivot<=arr1 & value1=0 -> (state'=12) & (value2'=-1); // Sync State (s=2)

    [] state=12 & value2=-1 -> 0.5 : (state'=4) & (value2'=1) + 0.5 : (state'=5) & (value2'=0);
    [] state=4 & value2=1 -> (state'=13) & (value3'=-1); // Sync State (s=3)
    [] state=5 & value2=0 -> (state'=13) & (value3'=-1); // Sync State (s=3)

    [] state=13 & value3=-1 -> 0.5 : (state'=6) & (value3'=1) + 0.5 : (state'=7) & (value3'=0);
    [] state=6 & value3=1 -> (state'=14) & (value4'=-1); // Sync State (s=4)
    [] state=7 & value3=0 -> (state'=14) & (value4'=-1); // Sync State (s=4)
    
    [] state=14 & value4=-1 -> 0.5 : (state'=8) & (value4'=1) + 0.5 : (state'=9) & (value4'=0);
    [] state=8 & value4=1 -> (state'=15) & (value5'=-1); // Sync State (s=5)
    [] state=9 & value4=0 -> (state'=15) & (value5'=-1); // Sync State (s=5)

    [] state=15 & value5=-1 -> 0.5 : (state'=11) & (value5'=1) + 0.5 : (state'=10) & (value5'=0);
    [] state=11 & value5=1 -> (state'=16); // Sync State (s=6)
    [] state=10 & value5=0 -> (state'=16); // Sync State (s=6)
 
    [done] state=16 -> (state'=16); 

endmodule

init pivot=-1&state=0  endinit

formula sumvalue = 1 * value1 + 2 * value2 + 4 * value3 + 8 * value5;

rewards "path_sum1"
	[] sumvalue<=7 : 1;
endrewards