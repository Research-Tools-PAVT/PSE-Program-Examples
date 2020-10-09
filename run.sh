rm -rf klee* *.bc *.dot *.out
clang++ -I ../../home/klee/klee_src/include -c -emit-llvm -g -O1 -Xclang -disable-O0-optnone monty_hall.cpp

klee --print-exectree monty_hall.bc
klee --print-exectree --set-codeflow monty_hall.bc

ktest-tool klee-last/test000002.ktest

gcc -I ../../home/klee/klee_src/include/ -L ../home/klee/klee_build/lib/ monty_hall.cpp -lkleeRuntest
KTEST_FILE=klee-last/test000002.ktest ./a.out

echo $?
