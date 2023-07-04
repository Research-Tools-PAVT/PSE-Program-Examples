# Probabilistic Symbolic Execution

We present two new functions one for declaring a `probabilistic` variable and the other for getting a `KLEE KQuery` dump
for a given variable, this can later be extended to get all `Valid KQuery` expressions in the `Constraint Set` processed so far in the execution path.

### Modified KLEE Repository :

Clone & Build [KLEE](http://klee.github.io/build-llvm9/).

- [KLEE - Symbolic Tree](https://github.com/lahiri-phdworks/klee/tree/symbolic_tree)
- Installation Guide : [Install.md](Install.md)

```bash
export HOME=/home

# LLVM 10, clang-10 build
git clone https://github.com/klee/klee-uclibc.git
cd klee-uclibc
./configure --make-llvm-lib --with-llvm-config $(which llvm-config-10) --with-cc $(which clang-10) --enable-assertions --enable-release
make -j 8
   
mkdir libcxx-build
cd ./klee

LLVM_VERSION=10 BASE=$HOME/libcxx-build REQUIRES_RTTI=1 DISABLE_ASSERTIONS=1 \
    ENABLE_DEBUG=0 ENABLE_OPTIMIZED=1 ./scripts/build/build.sh libcxx

cd ../
mkdir klee-build && cd ./klee-build

cmake \
  -DENABLE_POSIX_RUNTIME=ON \
  -DENABLE_KLEE_UCLIBC=ON \
  -DKLEE_UCLIBC_PATH=$HOME/klee-uclibc \
  -DLLVM_CONFIG_BINARY=$(which llvm-config-10) \
  -DLLVMCC=$(which clang-10) \
  -DLLVMCXX=$(which clang++-10) \
  -DENABLE_KLEE_LIBCXX=ON \
  -DENABLE_KLEE_EH_CXX=ON \
  -DKLEE_RUNTIME_BUILD_TYPE=Release+Debug+Asserts \
  -DKLEE_LIBCXX_DIR=$HOME/libcxx-build/libc++-install-90/ \
  -DKLEE_LIBCXXABI_SRC_DIR=$HOME/libcxx-build/llvm-90/libcxxabi/ \
  -DKLEE_LIBCXX_INCLUDE_DIR=$HOME/libcxx-build/libc++-install-90/include/c++/v1/ \
  -DENABLE_KLEE_EH_CXX=ON \
  -DENABLE_UNIT_TESTS=ON \
  -DGTEST_SRC_DIR=$HOME/googletest-release-1.7.0/ $HOME/klee
  
make -j 4
make install
```

### Plinko Directory :

- Developed by [Zach](https://github.com/zsusag). [plinko](https://git.justinh.su/)
- The directory [code](code/plinko/README.md) contains the tool.

#### Functions Added :

- `make_pse_symbolic(void *addr, size_t bytes, const char *name, T &&min_elem, T &&max_elem)` is the function that defines a `probabilistic` variable `addr` (pass by reference) with `symbolic` name `name` taking uniform distribution values from `min_elem` to `max_elem` range.

- `klee_dump_kquery_state()` gives the dump of the `constraints` at a state encountered at that program point (invoke point) in `kquery_dump.txt` file in the corresponding `klee_out` folder of the test case. Also prefer using `klee_print_expr()`.

- `klee_dump_symbolic_details(void *var_name, const char *name)` gives the symbolic constraint of the program variable (pass a reference) `var_name` of the program and prints the dump under `name` tag in `kquery_dump.txt` file in the corresponding `klee_out` folder of the test case.

- `mark_pse_symbolic(void *addr, size_t bytes, const char *name, T &&min_elem, T &&max_elem)` used internally to in `make_pse_symbolic()` function to mark a variable
  as `probablilistic symbolic`. This makes `KLEE` tag the variable and the `min` and `max` ranges into a `UniformInt(min, max)` distribution for the variable. It also used to generate the `*_dists.txt` file.

- `expected_value(const char* name, ...)` record and store a the execution value of a `program variable` internally while `KLEE` runs. The recorded value is used by `plinko` internally to compute the expected value of that program variable. Eg. `expected_value("SUM", sum);` records the value of variable sum for expecation calculation.

- `make_state_winning()` used to mark a state as winning. Used by `plinko` to generate and filter all `user` marked winning paths. Must be used in conjunction with the target query being `SAT`, which will filter and record all winning paths automatically.

#### `KQuery Expression` are s-expressions based on KLEE Kleaver expressions :

[KQuery Reference](https://klee.github.io/docs/kquery/)

## Python3 Dependencies

- Install [`python3`](https://www.python.org/downloads/release/python-387/) & [`pip3`](https://www.educative.io/edpresso/installing-pip3-in-ubuntu).
- Standard Packages : `re`, `sys`, `os`.

Some other essential packages include the following

- `graphviz` (https://pypi.org/project/graphviz/).
- `sexpdata` (https://sexpdata.readthedocs.io/en/latest/).
- `json` (https://docs.python.org/3/library/json.html).
- `uuid` (https://docs.python.org/3/library/uuid.html#example).
- `dot` or `xdot` binary must be available in the path.

```
$ pip3 install graphviz sexpdata
```

## Run Command

Some parameters :

```cpp
DUMPEXPECT=1 // Expectation calculation needed. (annontate your code with expected_value(const char* name, ...))
THREADS=1 // Number of concurrent threads for plinko to run (Max:2)
OPT=1 // Enable klee --optimize flag or not.
```

```bash
$ export DUMPEXPECT=1 THREADS=1 OPT=1 ./run.sh <src_dir> <file_name> <extra-args> <args-to-plinko>
```

## Running Examples

```bash
$ export DUMPEXPECT=1 THREADS=1 OPT=1 && /usr/bin/time -v \
--append --o timings.txt ./run.sh src/base/quicksort_all_N4.cpp \
expected-value
```

```bash
$ export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v \
--append --o timings.txt ./run.sh src/base/reservoir_sample_all.cpp \
reservoir-sample "-n 13 -k 7"
```

Check the `klee_results` folder for `paths` and `processed` symbolic execution tree.
After processing each test-case, a folder by the name `_processed` is build for that particular test case. This is how the `directory` structure would look like.

```
├── example1_klee_out
├── example1_processed
├── example2_klee_out
├── example2_processed
├── montyhall_klee_out
├── montyhall_processed
├── run.sh
└── ...
```

## Variable Types :

| Variable Type        | Output (make_symbolic_name) | Distribution Vector @init | Probability Vector @init |
| -------------------- | --------------------------- | ------------------------- | ------------------------ |
| `ForAll Vars`        | Yes                         | No                        | No                       |
| `Non-det Vars`       | Yes                         | Yes                       | No                       |
| `Probabilistic Vars` | Yes                         | Yes                       | Yes                      |

The sample code below explain the use accordingly.

- For `KQuery` dump, we see the `KQuery` & `SMTLIB2` constraints for the current ExecutionState in the path explored. The output is in a file `kquery_dump.txt`, where the constraints are dumped tagged by the location of the instruction for `klee_dump_kquery_state()` in the code file. This function now dumps for all states in the path for both `kquery` and `smtlib2` format.

# Examples

Probabilistic Symbolic Execution using KLEE, LLVM and Z3.
Replaying is a way to check the the testcase produced by KLEE for a given program, by running it concretely on the program.
For each complete path taken by KLEE, it generates one testcase containing the values of the `variables` marked `symbolic`, unless it
is `redundant` or `UNSAT`.

# Plinko Benchmark Commands.

```bash
# All (no-assumes cases) -- baseline.
export DUMPEXPECT=1 THREADS=1 OPT=0 && /usr/bin/time -v --append --o timings.txt ./run.sh src/extras/flips.cpp expected-value
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/montyhall_all.cpp calculate-prob
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/randomized_response_all.cpp calculate-prob
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/countminsketch_all.cpp countminsketch "-g 0.25"
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/freivalds_int_all.cpp freivalds "-k 1"
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/freivalds_multiple_int.cpp freivalds "-k 7"
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/bloomfilter_all.cpp bloom-filter "-e 0.39"
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/monotone_binary_int_all.cpp monotone-binary-search "-n 24"
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/reservoir_sample_v1_all.cpp reservoir-sample "-n 10 -k 4"
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/reservoir_sample_v2_all.cpp reservoir-sample "-n 12 -k 5"
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/reservoir_sample_all.cpp reservoir-sample "-n 13 -k 7"
export DUMPEXPECT=1 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/quicksort_all_N4.cpp expected-value
export DUMPEXPECT=1 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/quicksort_all_N5.cpp expected-value
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings.txt ./run.sh src/base/freivalds_int_orcase.cpp freivalds "-k 1"

# Assumes Instrumented cases.
export DUMPEXPECT=1 THREADS=1 OPT=0 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/extras/flips_assumes.cpp expected-value
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/montyhall_assumes.cpp calculate-prob
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/randomized_response_assumes.cpp calculate-prob
export DUMPEXPECT=1 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/quicksort_assumes_N4.cpp expected-value
export DUMPEXPECT=1 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/quicksort_assumes_N5.cpp expected-value
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/monotone_binary_int_assumes.cpp monotone-binary-search "-n 24"
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/freivalds_int_assumes.cpp freivalds "-k 1"
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/freivalds_multiple_int_assumes.cpp freivalds "-k 7"
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/reservoir_sample_v1_assumes.cpp reservoir-sample "-n 10 -k 4"
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/reservoir_sample_v2_assumes.cpp reservoir-sample "-n 12 -k 5"
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/reservoir_sample_assumes.cpp reservoir-sample "-n 13 -k 7"
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/bloomfilter_assumes.cpp bloom-filter "-e 0.39"
export DUMPEXPECT=0 THREADS=1 OPT=1 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/assumes/freivalds_int_orcase_assumes.cpp freivalds "-k 1"

export DUMPEXPECT=1 THREADS=1 OPT=0 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/extras/flips_assumes.cpp expected-value
export DUMPEXPECT=0 THREADS=1 OPT=0 && /usr/bin/time -v --append --o timings_assumes.txt ./run.sh src/extras/flips_assumes.cpp calculate-prob
```
