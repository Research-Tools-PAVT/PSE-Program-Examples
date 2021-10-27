#!/usr/bin/bash

export CC=$(which clang)
export CXX=$(which clang++)

cd bin
echo "== Deleting Tests =="
rm -rf tests

mkdir -p tests
cmake ..
make -j 8

./reservoir -p 1 -f 100 -r 15000 -n 1000 -l 0 2> matrix.md
./reservoir -p 1 -f 100 -r 25000 -n 1000 -l 0 2> matrix.md
