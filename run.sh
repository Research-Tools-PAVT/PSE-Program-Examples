#!/usr/bin/bash
SRC_PATH=$1
example=$2

clang++-10 -I $HOME/klee/include -I include -c -emit-llvm \
-std=c++17 -g -O0 -fPIC -fno-rtti -Xclang \
-disable-O0-optnone $SRC_PATH/${example}.cpp

klee --exit-on-error \
--disable-inlining --search=nurs:depth \
--set-ptree-dump --write-kqueries ${example}.bc --set-ptree-dump 

# for test in klee-last/*.ktest; do
#     echo " ---------------- "
#     echo "   $test" | lolcat -a
#     echo " ---------------- "
#     ktest-tool ${test}

#     clang++-10 -std=c++17 -march=native \
#     -I $HOME/klee/include/ -I include \
#     -L $HOME/klee/lib/ src/${example}.cpp -lkleeRuntest

#     KTEST_FILE=${test} ./a.out 
# done 

rm -rf ${example}_klee_out/
mkdir ${example}_klee_out/
mv klee-last/* ${example}_klee_out/
rm -rf klee* *.bc *.dot *.out *.o *.a

rm -rf ${example}_processed/
mkdir ${example}_processed/

python3 postprocess/reader.py ${example}_klee_out/conds_dump.txt ${example}
