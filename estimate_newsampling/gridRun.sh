#!/usr/bin/bash

timeout=$1
for n in 8 9 10 11;
do 
    for prob in 0.435 0.455 0.515 0.565 0.606 0.616 0.666;
    do
        for k in 250 500 1000 2000;
        do
            echo  "[Z3] Running for prob : ${prob}, n-flips : ${n}, k (sum-terms) : ${k} [Saving to models/prob_${prob}_${n}_dir/z3models_${k}_${prob}_${n}.json]"
            mkdir -p models/prob_${prob}_${n}_dir
            python3 candidates.py $k $n $prob $timeout models/prob_${prob}_${n}_dir/z3models_${k}_${prob}_${n}.json
        done
    done
done