#!/usr/bin/bash
export CC=$(which clang-13)
export CXX=$(which clang++-13)

cd bin
echo "==== Deleting Tests ===="
rm -rf tests
CC=$CC CXX=$CXX cmake ..

mkdir -p tests
make -j 8 ${1}