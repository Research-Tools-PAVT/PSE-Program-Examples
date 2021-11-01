#!/usr/bin/bash
SRC_PATH=$1
example=$2

clang++-10 -I $HOME/klee/include -I include -c -emit-llvm \
-std=c++17 -g -O0 -fPIC -fno-rtti -Xclang \
-disable-O0-optnone $SRC_PATH/${example}.cpp

clang++-10 -I $HOME/klee/include -I include -S -emit-llvm \
-std=c++17 -g -O0 -fPIC -fno-rtti -Xclang \
-disable-O0-optnone $SRC_PATH/${example}.cpp -o klee_results/llvmir/${example}.ll

klee --silent-klee-assume --solver-backend=z3 --use-batching-search \
--disable-inlining --only-output-states-covering-new \
--search=nurs:depth --smtlib-human-readable \
--set-ptree-dump --write-kqueries ${example}.bc

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

rm -rf klee_results/${example}_klee_out/
mkdir klee_results/${example}_klee_out/
mv klee-last/* klee_results/${example}_klee_out/
rm -rf klee-* *.bc *.dot *.out *.o *.a
rm -rf klee_results/${example}_processed/

python3 postprocess/reader.py klee_results/${example}_klee_out/conds_dump.txt ${example}
mv ${example}_processed klee_results/