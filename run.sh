#!/usr/bin/bash

stopwatch(){
    date1=`date +%s`;
    while true; do
        days=$(( $(($(date +%s) - date1)) / 86400 ))
        echo -ne "$days day(s) and $(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
        sleep 0.1
    done
}

mkdir -p klee_results
mkdir -p klee_results/llvmir
mkdir -p plinko-results

echo -e '\e[1;34mProcessing Paths ...\e[0m'
IFS=$'\n' read -r -d '' -a file_path_array < <( echo $1 | python3 -c '
import sys
import os
lines = []
for line in sys.stdin:
  lines.append(line)
pathsNames = lines[0].strip().split("/")
srcs = pathsNames[0:-1]
src = os.path.join(*srcs)
filenames = pathsNames[-1].strip().split(".")
filename = ".".join(filenames[0:-1])
print(f"{src}\n{filename}")
' && printf '\0' )

echo "Directory : " ${file_path_array[0]}
echo "File : " ${file_path_array[1]}

sleep 1

SRC_PATH=${file_path_array[0]}
example=${file_path_array[1]}

clang++-10 -I $HOME/klee/include -I include -c -emit-llvm \
-std=c++17 -g -O0 -fPIC -fno-rtti -Xclang \
-disable-O0-optnone $SRC_PATH/${example}.cpp

echo "Compilation : " > time.log
/usr/bin/time --append --verbose -o time.log clang++-10 -I $HOME/klee/include -I include -S -emit-llvm \
-std=c++17 -g -O0 -fPIC -fno-rtti -Xclang \
-disable-O0-optnone $SRC_PATH/${example}.cpp -o \
klee_results/llvmir/${example}.ll

echo "KLEE Symbolic Execution : " >> time.log
/usr/bin/time --append --verbose -o time.log \
klee --filename-act ${example} \
--disable-inlining --emit-all-errors \
--search=nurs:depth --search=nurs:covnew --dump-logs \
--use-cex-cache --write-kqueries ${example}.bc

echo -e "\e[1;39mKLEE Done ...\e[0m"

rm -rf klee_results/${example}_klee_out/
mkdir klee_results/${example}_klee_out/
mv klee-last/* klee_results/${example}_klee_out/
rm -rf klee_results/${example}_processed/
rm -rf klee-* *.bc *.dot *.out *.o *.a

mkdir -p plinko-results
mkdir -p plinko-results/${example}_processed

echo -e "\e[1;34mProcessing Dumps ...\e[0m"

echo "Path Processing : " >> time.log
/usr/bin/time --verbose --append -o time.log python3 \
postprocess/reader.py ${example}_summary.json \
${example} > plinko-results/${example}_processed/${example}_logs.txt

mv time.log plinko-results/${example}_processed/${example}_exec_time.txt

dot -Tpdf -Nfontsize=12 \
-Efontname=Courier-Bold -Efontsize=8 \
${example}_processed/${example}_execution_tree.dot > \
${example}_processed/${example}_execution_tree.dot.pdf

mv ${example}_summary.json ${example}_processed/${example}_summary.json
mv ${example}_processed klee_results/

mv klee_results/${example}_klee_out/*_dists.txt klee_results/${example}_processed/${example}_dists.txt

echo "Plinko running on ${example}_processed : " >> plinko-results/${example}_processed/${example}_exec_time.txt
echo -e "\e[1;34m===== Init Plinko =====\e[0m"

cd ./code/plinko
cabal v2-build

echo -e "\e[1;34m===== Run Plinko =====\e[0m"

/usr/bin/time --append --verbose -o \
../../plinko-results/${example}_processed/${example}_exec_time.txt \
cabal v2-run plinko -- \
-d ../../klee_results/${example}_processed \
-t 1 ${2} ${3} 2>> ../../plinko-results/${example}_processed/${example}_logs.txt \
> ../../plinko-results/${example}_processed/${example}_processed.txt

cat ../../plinko-results/${example}_processed/${example}_processed.txt >> complete_results.txt