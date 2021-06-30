#!/usr/bin/env bash
set -e
set -u
set -o pipefail

export CC=$(which clang)
export CXX=$(which clang++)
export RUNNER=$1

rm -rf bin/* 
rm -rf output/*
# rm -rf tests/*

# TODO : Replace with custom test generator (dummy-baseline) 
# These are inputs for the ForAll variables.
echo "  ---- Generating Inputs for ${RUNNER} ----  "
# for index in 1 2 3 4 5 6 7 8 9 10; 
# do 
#     dd if=/dev/random of=tests/input_${index}.txt bs=64 count=1
# done
# python3 generateInputs.py 250

echo "  ---- Building Binary : ${RUNNER} ----  "
cd bin/
CC=$CC CXX=$CXX cmake \
    -DCMAKE_CXX_FLAGS="-w -g -fsanitize=address -fsanitize=leak" \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ../
    
# clang-tidy -checks=* -p bin/ ../src/${RUNNER}.cpp
make -j 2
cd ../

echo "  ---- Running Binary : ${RUNNER} ----  "
bin/${RUNNER} < tests/input_1.txt
echo "  ---- ${RUNNER} ----  "