#!/usr/bin/bash

for k in 5 10 20 40 80 100;
do 
    for prob in 0.0 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 0.55 0.6 0.65 0.7 0.75 0.8 0.85 0.9 0.95 1;
    do
        echo  "[Z3] Running for prob : ${prob}, k (sum-terms) : ${k} [Saving to models/prob_${prob}_dir/z3models_${k}_${prob}_n10.log]"
        mkdir -p models/prob_${prob}_dir
        python3 candidates.py $k 10 $prob 3 > models/prob_${prob}_dir/z3models_${k}_${prob}_n10.log
    done
done