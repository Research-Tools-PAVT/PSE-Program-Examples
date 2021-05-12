#!/usr/bin/bash

timeout=10
for n in 10;
do 
    for prob in 0.30 0.40 0.70 0.80 0.90;
    do
        for k in 8 16 32 64 128 256 512;
        do
            echo  "[Z3] Running for prob : ${prob}, n-flips : ${n}, k (sum-terms) : ${k} [Saving to models/prob_${prob}_${n}_dir/z3models_${k}_${prob}_${n}.json]"
            mkdir -p models/prob_${prob}_${n}_dir
            timeout ${timeout}m python3 candidates.py $k $n $prob $timeout models/prob_${prob}_${n}_dir/z3models_${k}_${prob}_${n}.json
        done
    done
done