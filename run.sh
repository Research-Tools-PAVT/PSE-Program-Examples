rm -rf klee* *.bc *.dot

clang -I ../../home/klee/klee_src/include -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone sample_example.cpp
opt -dot-callgraph sample.bc

klee sample_example.bc --ptree-dump
ktest-tool klee-last/test000006.ktest

gcc -I ../../home/klee/klee_src/include/ -L ../home/klee/klee_build/lib/ sample_example.cpp -lkleeRuntest
KTEST_FILE=klee-last/test000006.ktest ./a.out

echo $?
