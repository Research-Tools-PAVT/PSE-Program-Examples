#!/usr/bin/bash

IFS=$'\n' read -r -d '' -a my_array < <( echo $1 | python3 -c '
import sys
lines = []
for line in sys.stdin:
  lines.append(line)
pathsNames = lines[0].strip().split("/")
src = pathsNames[0].strip()
filename = pathsNames[1].strip().split(".")[0].strip()
print(f"{src}\n{filename}")
' && printf '\0' )

echo "Directory : " ${my_array[0]}
echo "File : " ${my_array[1]}

sleep 2

SRC_PATH=${my_array[0]}
example=${my_array[1]}

clang++-10 -I $HOME/klee/include -I include -c -emit-llvm \
-std=c++17 -g -O0 -fPIC -fno-rtti -Xclang \
-disable-O0-optnone $SRC_PATH/${example}.cpp

clang++-10 -I $HOME/klee/include -I include -S -emit-llvm \
-std=c++17 -g -O0 -fPIC -fno-rtti -Xclang \
-disable-O0-optnone $SRC_PATH/${example}.cpp -o klee_results/llvmir/${example}.ll

klee --filename-act ${example} \
--disable-inlining --emit-all-errors --search=random-state \
--search=nurs:depth --search=nurs:md2u \
--use-cex-cache --write-kqueries ${example}.bc

# --only-output-states-covering-new

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

# cat klee_results/${example}_klee_out/conds_dump.txt | grep "Error" > klee_results/${example}_klee_out/states_removal.txt
# cat klee_results/${example}_klee_out/conds_dump.txt | grep "win" > klee_results/${example}_klee_out/success_states.txt

python3 postprocess/reader.py symbEx_tree.json ${example}

dot -Tpdf -Nfontsize=12 \
-Efontname=Courier-Bold -Efontsize=8 \
${example}_processed/${example}_execution_tree.dot > \
${example}_processed/${example}_execution_tree.dot.pdf

mv symbEx_tree.json ${example}_processed.states.json
mv ${example}_processed.states.json ${example}_processed/${example}_processed.states.json
mv ${example}_processed klee_results/