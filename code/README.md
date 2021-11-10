# Plinko

- Developed by [Zach](https://github.com/zsusag). [plinko](https://git.justinh.su/)

## Requirements

- [Haskell Cabal](https://www.haskell.org/cabal/)
- [KLEE - Symbolic Tree](https://github.com/lahiri-phdworks/klee/tree/symbolic_tree)

## Building

To build _Plinko_, navigate to the `plinko` directory and run the `cabal` build command:

```
$ cabal v2-build
```

## Usage

Currently, we only support a limited set of benchmarks and the `Z3` queries need to be handcoded. There is a four-step process for running a benchmark.

1. Execute the `./run.sh` script found in `./test/klee_examples/run.sh` with the name of the `.cpp` file as input. For example, to run the `reservoir_sample.cpp` benchmark, you would execute the following commands

```
$ cd test/klee_examples/
$ ./run.sh reservoir_sample
```

This will create two directories: `reservoir_sample_klee_out/` and `reservoir_sample_processed/`.

2. Create the distributions file for the example desired and name it as `{example}_processed/{example}_dists.txt`. See [distribution file syntax](#Distribution-File-Syntax) for more information on how to properly write the file.

3. Run _Plinko_ by providing the `{example}_processed/` directory path, number of threads you'd like Z3 to be run with (I'd suggest no more than 2 for optimal performance right now...), and which benchmark you'd like to run (aka, which query you'd like to ask). Note that some benchmarks require the user to provide the concretized settings for applicable variables.

For example, if you'd like to run the reservoir sampling benchmark, you need to provide _Plinko_ with the concretized setting of `n` and `k`. See the help pages for the subcommands in the _Plinko_ help menu for more information.

In general, a properly formed _Plinko_ command is of the following form

```
$ cabal v2-run plinko -- -d path/to/processed/dir -t 1 BENCHMARK {Concretizations}
```

Specifically, for reservoir sampling, where `n = 10` and `k = 5`, the command would be

```
$ cabal v2-run plinko -- -d test/klee_examples/reservoir_sample_processed/ -t 2 reservoir-sample -n 10 -k 5
$ cabal v2-run plinko -- -d ../../klee_results/quicksort_processed -t 2 expected-value
```

Note the `--` after `plinko`. This is _VERY_ important. This tells `cabal` to pass the following arguments/options to the `plinko` binary instead of `cabal`. If you'd like to avoid this syntax, you can also run

```
$ cabal v2-install exe:plinko
```

which will hopefully put the `plinko` executable somewhere on your `$PATH` (usually in `~/.cabal/bin`).

## Distribution File Syntax

A `*_dists.txt` file is of the format

```
prob_var_name ~ Distribution :: wN
```

where `prob_var_name` is the name of the probabilistic symbolic variable (the name given to the `make_pse_symbolic` call), Distribution is either

```
UniformInt(lower,upper)
Bernoulli(bias)
```

where `lower` and `upper` are integers and `bias` is a floating-point number, and `N` is the number of _bits_ the variable uses. Generally this will be `w32` for integers.

_There is currently a bug where if there is a trailing newline character at the end of the file you will get an error during parsing._

### Sample: `reservoir_sample_dists.txt`

Below is a sample `reservoir_sample_dists.txt` file which works up to `n=10`.

```
j_sym01 ~ UniformInt(0,1) :: w32
j_sym02 ~ UniformInt(0,2) :: w32
j_sym03 ~ UniformInt(0,3) :: w32
j_sym04 ~ UniformInt(0,4) :: w32
j_sym05 ~ UniformInt(0,5) :: w32
j_sym06 ~ UniformInt(0,6) :: w32
j_sym07 ~ UniformInt(0,7) :: w32
j_sym08 ~ UniformInt(0,8) :: w32
j_sym09 ~ UniformInt(0,9) :: w32
j_sym010 ~ UniformInt(0,10) :: w32
```

### Sample: `bloom_dists.txt`

For programs which randomly samples many times under the same name and domain (e.g., within a `for` loop), KLEE will automatically append a counter to the end of the probabilistic symbolic variable name.

For example, in `bloom.cpp`, `x_sym` is sampled numerous times in a `for` loop whenever an element is hashed. Since the distribution remains the same among all the variables (`x_sym`, `x_sym_1`, `x_sym_2`, etc.), it is only required to include the basename of the variable in the `_dists.txt` file.

```txt
x_sym ~ UniformInt(0,4) :: w32
```

The above line will tell _Plinko_ that whenever you see a probabilistic symbolic variable with the _prefix_ of `x_sym` to assign it the distribution `UniformInt(0,4)`.
