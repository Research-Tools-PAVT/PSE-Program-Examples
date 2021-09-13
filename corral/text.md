```bash
* * *           ESBMC 6.7.0          * * *

Main Usage:
  --input-file file.c ...        source file names

Options:
  -? [ --help ]                  show help

Printing options:
  --symbol-table-only            only show symbol table
  --symbol-table-too             show symbol table and verify
  --parse-tree-only              only show parse tree
  --parse-tree-too               show parse tree and verify
  --goto-functions-only          only show goto program
  --goto-functions-too           show goto program and verify
  --program-only                 only show program expression
  --program-too                  show program expression and verify
  --ssa-symbol-table             show symbol table along with SSA
  --ssa-guards
  --ssa-sliced                   print the sliced SSAs
  --ssa-no-location
  --smt-formula-only             only show SMT formula {not supported by all
                                 solvers},
  --smt-formula-too              show SMT formula (not supported by all
                                 solvers), and verify
  --smt-model                    show SMT model (not supported by all solvers),
                                 if the formula is SAT

Trace:
  --quiet                        do not print unwinding information during
                                 symbolic execution
  --compact-trace
  --symex-trace                  print instructions during symbolic execution
  --ssa-trace                    print SSA during SMT encoding
  --ssa-smt-trace                print generated SMT during SMT encoding
  --symex-ssa-trace              print generated SSA during symbolic execution
  --show-goto-value-sets         show value-set analysis for the goto functions
  --show-symex-value-sets        show value-set analysis during symbolic
                                 execution

Frontend:
  -I [ --include ] path          set include path
  -D [ --define ] macro          define preprocessor macro
  -W [ --warning ] arg
  -f [ --force ] arg
  --preprocess                   stop after preprocessing
  --no-inlining                  disable inlining function calls
  --full-inlining                perform full inlining of function calls
  --all-claims                   keep all claims
  --show-loops                   show the loops in the program
  --show-claims                  only show claims
  --show-vcc                     show the verification conditions
  --document-subgoals            generate subgoals documentation
  --no-arch                      don't set up an architecture
  --no-library                   disable built-in abstract C library
  --binary                       read goto program instead of source code
  --little-endian                allow little-endian word-byte conversions
  --big-endian                   allow big-endian word-byte conversions
  --16                           set width of machine word (default is 64)
  --32                           set width of machine word (default is 64)
  --64                           set width of machine word (default is 64)
  --version                      show current ESBMC version and exit
  --witness-output arg           generate the verification result witness in
                                 GraphML format
  --witness-producer arg
  --witness-programfile arg
  --old-frontend                 parse source files using our old frontend
                                 {deprecated},
  --result-only                  do not print the counter-example
  --i386-macos                   set MACOS/I386 architecture
  --ppc-macos                    set PPC/I386 architecture
  --i386-linux                   set Linux/I386 architecture (default),
  --i386-win32                   set Windows/I386 architecture
  --funsigned-char               make "char" unsigned by default
  --fms-extensions               enable microsoft C extensions

BMC:
  --function name                set main function name
  --claim nr                     only check specific claim
  --instruction nr               limit the number of instructions executed
                                 during symbolic execution
  --unwind nr                    unwind nr times
  --unwindset nr                 unwind given loop nr times
  --no-unwinding-assertions      do not generate unwinding assertions
  --partial-loops                permit paths with partial loops
  --unroll-loops
  --no-slice                     do not remove unused equations
  --slice-assumes                remove unused assume statements
  --extended-try-analysis
  --skip-bmc

Incremental BMC:
  --incremental-bmc              incremental loop unwinding verification
  --falsification                incremental loop unwinding for bug searching
  --termination                  incremental loop unwinding assertion
                                 verification

Solver:
  --list-solvers                 list available solvers and exit
  --boolector                    use Boolector (default),
  --z3                           use Z3
  --mathsat                      use MathSAT
  --cvc                          use CVC4
  --yices                        use Yices
  --bitwuzla                     use Bitwuzla
  --bv                           use solver with bit-vector arithmetic
  --ir                           use solver with integer/real arithmetic
  --smtlib                       use SMT lib format
  --smtlib-solver-prog arg       SMT lib program name
  --output <filename>            output VCCs in SMT lib format to given file
  --floatbv                      encode floating-point using the SMT
                                 floating-point theory(default)
  --fixedbv                      encode floating-point as fixed bit-vectors
  --fp2bv                        encode floating-point as bit-vectors(default
                                 for solvers that don't support the SMT
                                 floating-point theory)
  --tuple-node-flattener         encode tuples using our tuple to node API
  --tuple-sym-flattener          encode tuples using our tuple to symbol API
  --array-flattener              encode arrays using our array API
  --no-return-value-opt          disable return value optimization to compute
                                 the stack size

Incremental SMT:
  --smt-during-symex             enable incremental SMT solving {experimental},
  --smt-thread-guard             check the thread guard during thread
                                 exploration {experimental},
  --smt-symex-guard              check conditional goto statements during
                                 symbolic execution {experimental},
  --smt-symex-assert             check assertion statements during symbolic
                                 execution {experimental},

Property checking:
  --no-assertions                ignore assertions
  --no-bounds-check              do not do array bounds check
  --no-div-by-zero-check         do not do division by zero check
  --no-pointer-check             do not do pointer check
  --no-align-check               do not check pointer alignment
  --no-pointer-relation-check    do not check pointer relations
  --nan-check                    check floating-point for NaN
  --memory-leak-check            enable memory leak check
  --overflow-check               enable arithmetic over- and underflow check
  --deadlock-check               enable global and local deadlock check with
                                 mutex
  --data-races-check             enable data races check
  --lock-order-check             enable for lock acquisition ordering check
  --atomicity-check              enable atomicity check at visible assignments
  --stack-limit bits (=-1)       check if stack limit is respected
  --error-label label            check if label is unreachable
  --force-malloc-success         do not check for malloc/new failure

k-induction:
  --base-case                    check the base case
  --forward-condition            check the forward condition
  --inductive-step               check the inductive step
  --k-induction                  prove by k-induction
  --k-induction-parallel         prove by k-induction, running each step on a
                                 separate process
  --k-step nr (=1)               set k increment (default is 1)
  --max-k-step nr (=50)          set max number of iteration (default is 50)
  --show-cex                     print the counter-example produced by the
                                 inductive step
  --bidirectional
  --unlimited-k-steps            set max number of iteration to UINT_MAX
  --max-inductive-step nr (=-1)

Scheduling:
  --schedule                     use schedule recording approach
  --round-robin                  use the round robin scheduling approach
  --time-slice nr (=1)           set the time slice of the round robin
                                 algorithm (default is 1)

Concurrency checking:
  --context-bound nr (=-1)       limit number of context switches for each
                                 thread
  --state-hashing                enable state-hashing, prunes duplicate states
  --no-por                       do not do partial order reduction
  --all-runs                     check all interleavings, even if a bug was
                                 already found

Miscellaneous options:
  --memlimit limit               configure memory limit, of form "100m" or "2g"
  --memstats                     print memory usage statistics
  --timeout t                    configure time limit, integer followed by
                                 {s,m,h}
  --enable-core-dump             do not disable core dump output
  --no-simplify                  do not simplify any expression
  --no-propagation               disable constant propagation
  --interval-analysis            enable interval analysis for integer variables
                                 and add assumes to the program
  --add-symex-value-sets         enable value-set analysis for pointers and add
                                 assumes to the program

DEBUG options:
  --git-hash
  --double-assign-check
  --abort-on-recursion
  --verbosity arg
  --break-at arg
  --direct-interleavings
  --print-stack-traces
  --interactive-ileaves
```
