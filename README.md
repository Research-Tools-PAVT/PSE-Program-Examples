# PSE 

Probabilistic Symbolic Execution

## KLEE using Dockers

```bash 
clang -I ../../home/klee/klee_src/include -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone montyhall.cpp

klee montyhall.bc

ktest-tool klee-last/test000001.ktest
ktest-tool klee-last/test000002.ktest
ktest-tool klee-last/test000003.ktest

export LD_LIBRARY_PATH=../../home/klee/klee_build/lib/:$LD_LIBRARY_PATH

gcc -I ../../home/klee/klee_src/include/ -L ../home/klee/klee_build/lib/ montyhall.cpp -lkleeRuntest
echo $?

```
