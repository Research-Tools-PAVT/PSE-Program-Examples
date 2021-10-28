#!/usr/bin/bash

export CC=$(which clang)
export CXX=$(which clang++)

cd bin
echo "== Deleting Tests =="
rm -rf *

mkdir -p tests
cmake ..
make -j 8

./reservoir -p 1 -f 50 -r 1500 -n 1000 -l 0 2> matrix.md
./reservoir -p 1 -f 50 -r 2500 -n 1000 -l 0 2> matrix.md
