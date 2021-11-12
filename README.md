# Probabilistic Symbolic Execution

We present two new functions one for declaring a `probabilistic` variable and the other for getting a `KLEE KQuery` dump
for a given variable, this can later be extended to get all `Valid KQuery` expressions in the `Constraint Set` processed so far in the execution path.

### Modified KLEE Repository :

Clone & Build [KLEE](http://klee.github.io/build-llvm9/).

- [KLEE - Symbolic Tree](https://github.com/lahiri-phdworks/klee/tree/symbolic_tree)
- Installation Guide : [Install.md](Install.md)

### Plinko Directory :

- Developed by [Zach](https://github.com/zsusag). [plinko](https://git.justinh.su/)
- The directory [code](code/plinko/README.md) contains the tool.

#### Functions Added :

- `make_pse_symbolic(void *addr, size_t bytes, const char *name, T &&min_elem, T &&max_elem)` is the function that defines a `probabilistic` variable `addr` (pass by reference) with `symbolic` name `name` taking uniform distribution values from `min_elem` to `max_elem` range.

- `klee_dump_kquery_state()` gives the dump of the `constraints` at a state encountered at that program point (invoke point) in `kquery_dump.txt` file in the corresponding `klee_out` folder of the test case. Also prefer using `klee_print_expr()`.

- `klee_dump_symbolic_details(void *var_name, const char *name)` gives the symbolic constraint of the program variable (pass a reference) `var_name` of the program and prints the dump under `name` tag in `kquery_dump.txt` file in the corresponding `klee_out` folder of the test case.

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

```bash
$ ./run.sh <src_dir> <file_name> <extra-args> <args-to-plinko>
```

## Running Examples

```bash
$ ./run.sh src/montyhall_all.cpp calculate-prob
```

```bash
$ ./run.sh src/reservoir_sample_v1_all.cpp reservoir-sample "-n 10 -k 4"
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

# All Files Execution (Done)

```
./run.sh src/montyhall_all.cpp calculate-prob
./run.sh src/randomized_response_all.cpp calculate-prob
./run.sh src/bloomfilter_all.cpp calculate-prob
./run.sh src/freivalds_int_all.cpp calculate-prob
./run.sh src/monotone_binary_int_all.cpp calculate-prob
./run.sh src/reservoir_sample_v1_all.cpp reservoir-sample "-n 10 -k 4"
./run.sh src/reservoir_sample_v2_all.cpp reservoir-sample "-n 15 -k 6"
./run.sh src/quicksort_all_N4.cpp expected-value
sed -i "s/-t 2/-t 1/g" run.sh
./run.sh src/quicksort_all_N5.cpp expected-value
sed -i "s/-t 1/-t 2/g" run.sh
```

# Assume Files Execution (WIP)

```
./run.sh src/assumes/montyhall_assumes.cpp calculate-prob
./run.sh src/assumes/randomized_response_assumes.cpp calculate-prob
./run.sh src/assumes/bloomfilter_assumes.cpp calculate-prob
./run.sh src/assumes/freivalds_int_assumes.cpp calculate-prob
./run.sh src/assumes/monotone_binary_int_assumes.cpp calculate-prob
./run.sh src/assumes/reservoir_sample_v1_assumes.cpp reservoir-sample "-n 10 -k 4"
./run.sh src/assumes/reservoir_sample_v2_assumes.cpp reservoir-sample "-n 15 -k 6"
./run.sh src/assumes/quicksort_assumes_N4.cpp expected-value
sed -i "s/-t 2/-t 1/g" run.sh
./run.sh src/assumes/quicksort_assumes_N5.cpp expected-value
sed -i "s/-t 1/-t 2/g" run.sh
```
