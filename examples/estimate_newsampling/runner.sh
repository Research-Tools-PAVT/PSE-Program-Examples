#!/usr/bin/bash

prob=$1
n=$2
k=$3
timeoutf=$4

echo  "[Z3] Running for prob : ${prob}, n-flips : ${n}, k (sum-terms) : ${k} [Saving to models/prob_${prob}_${n}_dir/z3models_${k}_${prob}_${n}.json]"
mkdir -p models/prob_${prob}_${n}_dir
python3 candidates.py $k $n $prob $timeoutf models/prob_${prob}_${n}_dir/z3models_${k}_${prob}_${n}.json