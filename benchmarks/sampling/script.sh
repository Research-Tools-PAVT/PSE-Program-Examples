#!/usr/bin/bash

export CC=$(which clang)
export CXX=$(which clang++)
test=$1

cd bin
CC=$(which clang-13) CXX=$(which clang++-13) cmake ..
echo "== Deleting Tests =="
rm -rf *

mkdir -p tests
make -j8 ${test}

./${test}
