#!/usr/bin/bash

timeout=$1
for n in 5 6 7 8;
do 
    for prob in 0.10 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95;
    do
        for k in 8 16 32 64 128 256;
        do
            echo  "[Z3] Running for prob : ${prob}, n-flips : ${n}, k (sum-terms) : ${k} [Saving to models/prob_${prob}_${n}_dir/z3models_${k}_${prob}_${n}.json]"
            mkdir -p models/prob_${prob}_${n}_dir
            timeout ${timeout}m python3 candidates.py $k $n $prob $timeout models/prob_${prob}_${n}_dir/z3models_${k}_${prob}_${n}.json
        done
    done
done