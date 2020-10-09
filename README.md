# PSE Project

Probabilistic Symbolic Execution using KLEE, LLVM and Z3. 

## KLEE ETree Dump

#####  Monty Hall Example 
 
```bash 
rm -rf klee* *.bc *.dot *.out
clang++ -I ../../home/klee/klee_src/include -c -emit-llvm -g -O1 -Xclang -disable-O0-optnone monty_hall.cpp

klee --print-exectree monty_hall.bc
klee --print-exectree --set-codeflow monty_hall.bc

ktest-tool klee-last/test000002.ktest

gcc -I ../../home/klee/klee_src/include/ -L ../home/klee/klee_build/lib/ monty_hall.cpp -lkleeRuntest
KTEST_FILE=klee-last/test000002.ktest ./a.out

echo $?
```

#### Sample Run

```bash
rm -rf klee* *.bc *.dot *.out
clang++ -I ../../home/klee/klee_src/include -c -emit-llvm -g -O1 -Xclang -disable-O0-optnone sample_example.cpp

klee --print-exectree sample_example.bc
klee --print-exectree --set-codeflow sample_example.bc

ktest-tool klee-last/test000002.ktest

gcc -I ../../home/klee/klee_src/include/ -L ../home/klee/klee_build/lib/ sample_example.cpp -lkleeRuntest
KTEST_FILE=klee-last/test000002.ktest ./a.out

echo $?
```

## Sample Output 

```bash
KLEE: output directory is "/home/vmconsys655/pse_project/klee-out-1"
KLEE: Using Z3 solver backend

KLEE: done: total instructions = 492
KLEE: done: completed paths = 2
KLEE: done: generated tests = 2
ktest file : 'klee-last/test000002.ktest'
args       : ['sample_example.bc']
num objects: 3
object 0: name: 'a_pse_sym'
object 0: size: 4
object 0: data: b'\x00\x00\x00\x00'
object 0: hex : 0x00000000
object 0: int : 0
object 0: uint: 0
object 0: text: ....
object 1: name: 'b_pse_sym'
object 1: size: 4
object 1: data: b'\x00\x00\x00\x00'
object 1: hex : 0x00000000
object 1: int : 0
object 1: uint: 0
object 1: text: ....
object 2: name: 'c_sym'
object 2: size: 4
object 2: data: b'2\x00\x00\x00'
object 2: hex : 0x32000000
object 2: int : 50
object 2: uint: 50
object 2: text: 2...
159
```
