clang++ -I $HOME/klee/include -c -emit-llvm -std=c++17 -g -O0 -Xclang -disable-O0-optnone $1.cpp

klee --search=random-state --search=nurs:md2u --write-kqueries $1.bc --set-ptree-dump 
ktest-tool klee-last/test000001.ktest

g++ -std=c++14 -march=native -I $HOME/klee/include/ -L $HOME/klee/lib/ $1.cpp -lkleeRuntest
KTEST_FILE=klee-last/test000001.ktest ./a.out

rm -rf $1_klee_out/
mkdir $1_klee_out/
mv klee-last/* $1_klee_out/
rm -rf klee* *.bc *.dot *.out

rm -rf $1_processed/
mkdir $1_processed/

python3 postprocess/reader.py ./$1_klee_out/conds_dump.txt $1