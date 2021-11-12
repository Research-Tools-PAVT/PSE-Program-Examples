#!/usr/bin/bash

for N in {2..6}
do
		echo "N = ${N}"
		sed -i "s/const int N = [0-9]\+;/const int N = $N;/g" reservoir_sampling*.prism
		for i in {2..6}
		do
				start=`date +%s.%N`
				storm --prism reservoir_sampling-${i}.prism --prop reservoir_sampling-correctness.prop 2>&1 > /dev/null
				end=`date +%s.%N`
				echo "$end - $start" | bc -l
		done
done
