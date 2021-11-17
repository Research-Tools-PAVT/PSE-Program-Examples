#!/usr/bin/bash
# export DUMPEXPECT=0 THREADS=1 OPT=1 ./run.sh src/assumes/montyhall_assumes.cpp calculate-prob
# export DUMPEXPECT=0 THREADS=1 OPT=1 ./run.sh src/assumes/randomized_response_assumes.cpp calculate-prob
# export DUMPEXPECT=0 THREADS=1 OPT=1 ./run.sh src/assumes/bloomfilter_assumes.cpp calculate-prob
# export DUMPEXPECT=0 THREADS=1 OPT=1 ./run.sh src/assumes/freivalds_int_assumes.cpp calculate-prob
# export DUMPEXPECT=0 THREADS=1 OPT=1 ./run.sh src/assumes/monotone_binary_int_assumes.cpp calculate-prob
# export DUMPEXPECT=0 THREADS=1 OPT=1 ./run.sh src/assumes/reservoir_sample_v1_assumes.cpp reservoir-sample "-n 10 -k 4"
# export DUMPEXPECT=0 THREADS=1 OPT=1 ./run.sh src/assumes/reservoir_sample_v2_assumes.cpp reservoir-sample "-n 12 -k 5"
# export DUMPEXPECT=0 THREADS=1 OPT=1 ./run.sh src/assumes/quicksort_assumes_N4.cpp expected-value
# sed -i "s/-t 2/-t 1/g" run.sh
# export DUMPEXPECT=0 THREADS=1 OPT=1 ./run.sh src/assumes/quicksort_assumes_N5.cpp expected-value
# sed -i "s/-t 1/-t 2/g" run.sh

# export DUMPEXPECT=1 THREADS=1 OPT=0 && /usr/bin/time -v --append --o timings.txt ./run.sh src/extras/flips.cpp expected-value
# export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/montyhall_all.cpp calculate-prob
# export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/randomized_response_all.cpp calculate-prob
# export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/countminsketch_all.cpp countminsketch "-g 0.25"
# export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/freivalds_int_all.cpp freivalds "-k 1"
# export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/freivalds_multiple_int.cpp freivalds "-k 7"
# export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/bloomfilter_all.cpp bloom-filter "-e 0.39"
# export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/monotone_binary_int_all.cpp monotone-binary-search "-n 24"
# export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/reservoir_sample_v1_all.cpp reservoir-sample "-n 10 -k 4"
# export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/reservoir_sample_v2_all.cpp reservoir-sample "-n 12 -k 5"
# export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/reservoir_sample_all.cpp reservoir-sample "-n 13 -k 7"
# export DUMPEXPECT=1 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/quicksort_all_N4.cpp expected-value
# export DUMPEXPECT=1 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/quicksort_all_N5.cpp expected-value
# export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/freivalds_int_orcase.cpp freivalds "-k 1"

# export DUMPEXPECT=1 THREADS=1 OPT=0 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/extras/flips_assumes.cpp expected-value
# export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/montyhall_assumes.cpp calculate-prob
# export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/randomized_response_assumes.cpp calculate-prob
# export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/freivalds_int_assumes.cpp freivalds "-k 1"
# export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/freivalds_multiple_int_assumes.cpp freivalds "-k 7"
export DUMPEXPECT=1 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/quicksort_assumes_N4.cpp expected-value
# export DUMPEXPECT=1 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/quicksort_assumes_N5.cpp expected-value