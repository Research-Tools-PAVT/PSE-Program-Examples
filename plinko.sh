#!/usr/bin/bash

example=$1

mkdir -p plinko-results
mkdir -p plinko-results/${example}_processed

echo "Plinko running on ${example}_processed" > plinko-results/${example}_processed/${example}_time.txt

echo "==== Init Plinko ===="

cd ./code/plinko

cabal v2-build

echo "==== Run Plinko ===="

/usr/bin/time --append --verbose -o \
../../plinko-results/${example}_processed/${example}_time.txt \
cabal v2-run plinko -- \
-d ../../klee_results/${example}_processed \
-t 2 ${2} ${3} 2> ../../plinko-results/${example}_processed/${example}_logs.txt \
> ../../plinko-results/${example}_processed/${example}_processed.txt