We thank the reviewers for their thoughtful comments.

Our paper proposes a symbolic execution method for randomized programs, which
can verify the correctness of programs on all possible inputs. As far as we are
aware, no prior automated method is able to analyze our case studies, which are
all randomized programs with unknown inputs. Our KLEE-based prototype
implementation works on LLVM bytecode, enabling us to analyze real-world
programs, rather than idealized mathematical models. 

# Unknown inputs, comparison with PPLs (Reviewers A and C)

We emphasize that we are considering a different setting than probabilistic
programming languages (PPLs). In PPLs, inputs are described by some known
distribution and programs encode a *single* distribution. In our setting, inputs
are universally quantified and not drawn from a distribution, and programs
represent a *family* of output distributions, one for each possible input. We
verify properties of the entire family of distributions, while PPLs to reason
about a single distribution. None of the approaches mentioned on
L1171---including Hakaru---can handle universally quantified inputs, like our
approach does.

Reviewer C points out that our method does not handle conditioning operations,
which are common in PPLs. This is correct, but our targets---executable
randomized programs---do not make use of conditioning, because it is not
computationally tractable.

# Exhaustive search (Reviewer A)

We do not expect exhaustive search to scale beyond what we have shown, but even
with this method, we were able to verify complex programs beyond the reach of
prior work. Additionally, even with our relatively small concretizations, we
could find subtle bugs (Section 5.2).

For programs that are too large to allow for full path exploration, our method
can prove lower-bounds on the probability of some predicate $\Psi$ being
satisfied by exploring a subset of the paths (L535).

# Language of symbolic formula (Reviewer A)

Formulas use the binary operator "+" to create a single expression. While the
reviewer is correct that these expressions can be quite large, this encoding
seems tractable for programs that don't have long sequences of sampling
instructions, like our case studies. We will be more explicit about the form of
these symbolic formulae; exploring compact encodings of sums is future work.

# Model checking (Reviewers A & B)

We could not compare our work with model checkers as we are not aware of any
existing tools that can handle our examples:

1) Probabilistic model checkers work with probabilistic automata, but our
imperative programs lead to automata with enormous state spaces. It is also not
trivial to faithfully model details of our machine model.
2) We universally quantify over inputs, rather than fixing inputs to be specific
constants. We are not aware of any probabilistic model checker that has direct
support for this kind of system.
3) One indirect way to leverage existing tools would be to encode programs as
MDPs, with a non-deterministic choice over all possible inputs.  However, we are
not aware of tools that can handle such a wide non-deterministic choice.

# Similarity to traditional symbolic execution (Reviewer B)

Our method is an extension of symbolic execution, but one that we believe seems
obvious only in retrospect. Building firmly on symbolic execution is a strength,
as it allows us to adapt existing symbolic execution methods (e.g., KLEE).

# Potential optimizations (Reviewer C)

We are optimistic about improving scalability (via optimizations like state merging~[Kuznetsov et al. PLDI'12] and better encodings of sums as formulas), but we do not make any concrete
claims at this time. We keep optimizations as future work.
