rm -rf klee* *.bc *.dot *.out
clang++ -I $HOME/klee/klee_src/include -c -emit-llvm -g -O1 -Xclang -disable-O0-optnone $1.cpp

klee --write-kqueries $1.bc
ktest-tool klee-last/test000001.ktest

g++ -std=c++14 -march=native -I $HOME/klee/klee_src/include/ -L $HOME/klee/klee_build/lib/ $1.cpp -lkleeRuntest
KTEST_FILE=klee-last/test000001.ktest ./a.out

echo $?