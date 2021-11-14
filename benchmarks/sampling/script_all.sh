#!/usr/bin/bash
export CC=$(which clang-13)
export CXX=$(which clang++-13)

cd bin
echo "==== Deleting Tests ===="
rm -rf tests
CC=$CC CXX=$CXX cmake -DCMAKE_CXX_FLAGS="-fsanitize=address -fsanitize=leak" ..

mkdir -p tests
make -j 8 all

echo "==== Executing ===="
./bloomfilter
./freivalds_int
./monotone_binary_int
./montyhall
./quicksort_N4
./quicksort_N5
./randomized_response
./reservoir_v1
./reservoir_v2