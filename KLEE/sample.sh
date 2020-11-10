rm -rf klee* *.bc *.dot *.out
clang++ -I ../../home/klee/klee_src/include -c -emit-llvm -g -O1 -Xclang -disable-O0-optnone sample_example.cpp

klee --print-exectree sample_example.bc
klee --print-exectree --set-codeflow sample_example.bc

ktest-tool klee-last/test000001.ktest

gcc -I ../../home/klee/klee_src/include/ -L ../home/klee/klee_build/lib/ sample_example.cpp -lkleeRuntest
KTEST_FILE=klee-last/test000001.ktest ./a.out

echo $?
