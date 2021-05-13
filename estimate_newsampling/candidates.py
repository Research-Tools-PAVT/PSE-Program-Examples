# -*- coding: utf-8 -*-

import z3
import os
import sys
import json
import time
from alive_progress import alive_bar

# from scipy.stats import bernoulli

# https://z3prover.github.io/api/html/classz3py_1_1_rat_num_ref.html#a1012d6314d35530c58f9c018269ec867
def num(r):
    """
    Convert from Z3 to python float values.
    """
    return float(r.numerator_as_long()) / float(r.denominator_as_long())


def get_value(r):
    # https://stackoverflow.com/questions/12598408/z3-python-getting-python-values-from-model/12600208
    """
    Convert from Z3 to python values.
    """
    if z3.is_true(r):
        return z3.is_true(r)
    elif z3.is_false(r):
        return z3.is_false(r)
    elif z3.is_int_value(r):
        return r.as_long()
    elif z3.is_algebraic_value(r):
        return round(num(r.approx(15)), 10)
    elif z3.is_rational_value(r):
        return r.as_decimal(20)
    elif r is None:
        None
    else:
        return num(r)


"""
Below are a list of constraints that dictate which 
path is taken during actual program execution. 
We process KLEE constraints and simplify them to get these 
constraints. 
"""

# pwd = os.path.dirname(__file__)
# if not os.path.isdir(os.path.join(pwd, "inputs")):
#     os.mkdir(os.path.join(pwd, "inputs"))

# inputFilePath = os.path.join(pwd, "inputs")

z3.set_option(
    precision=10,
    rational_to_decimal=True,
    max_args=100000,
    max_lines=100000,
    max_depth=100000,
    max_visited=100000,
)

error_mass = z3.Real("error_mass_expectation")
sum_of_k = z3.Real("sum_of_k")
sigma_w_i = z3.Real("sigma_w_i")
assert_violated = z3.Int("assert_violated")


def generateCandidates(k: int, n: int, prob: float):

    candidatePaths = k  # Top "k" paths.
    n_iters = n  # "n" bernoulli trails (independent fair coin flips)

    probability_factor = z3.Real("probability_factor")

    choice_sym_vars = [
        [z3.Real(f"choice_{k}_{i}") for i in range(n_iters)]
        for k in range(candidatePaths)
    ]

    d_sym_vars = [
        [z3.Int(f"d_{k}_{i}") for i in range(n_iters)] for k in range(candidatePaths)
    ]

    path_prob_sym_vars = [z3.Real(f"path_prob_{i}") for i in range(candidatePaths)]
    probability_vars = [z3.Real(f"probability_{k}") for k in range(candidatePaths)]

    expected_heads = [z3.Real(f"expected_heads_{k}") for k in range(candidatePaths)]
    sum_d_heads = [z3.Real(f"sum_heads_{k}") for k in range(candidatePaths)]

    optpath = z3.Optimize()

    # COMMENT : Supply the timeout in minute value.
    optpath.set("timeout", 60000 * int(sys.argv[4]))

    optpath.add(probability_factor == float(prob))

    with alive_bar(candidatePaths) as executeBar:

        # "k" models. One model for each randomized run.
        for k in range(candidatePaths):

            # initalization
            sum_heads = 0
            path_prob = 1
            expected_heads_run = 0

            # optpath.add(0.0001 <= probability_vars[k])
            # optpath.add(probability_vars[k] < 1.0)

            # Prob value is now concrete, so we get a single number at the end.
            optpath.add(probability_vars[k] == probability_factor)

            # "n_iters" coin toss.
            for i in range(n_iters):

                optpath.add(0 <= d_sym_vars[k][i])
                optpath.add(d_sym_vars[k][i] <= 1)

                # COMMENT : Value of "d" must come from a distribution?
                # optpath.add(
                #     d_sym_vars[k][i] == int(bernoulli.rvs(size=1, p=float(prob))[0])
                # )

                # Choice Prob ITE.
                optpath.add(
                    choice_sym_vars[k][i]
                    == z3.If(
                        d_sym_vars[k][i] == 1,
                        probability_vars[k],
                        1 - probability_vars[k],
                    )
                )

                # E[heads for "i-th" run] = sum (choice_prob * d_value) for i-th run.
                # expected_heads_run += choice_sym_vars[k][i] * d_sym_vars[k][i] # max_value => n_iters * prob

                # Heads in this current "n" flips of the iteration. x(i) term
                # We get one "sum_heads" value of each model in "k" models.
                sum_heads += d_sym_vars[k][i]

                # Path probs is multiplication of choice probs. w(i) term
                path_prob *= choice_sym_vars[k][i]

            # path_prob = path_prob * choice_prob, array of w(i) terms
            optpath.add(path_prob_sym_vars[k] == path_prob)

            # Sum heads is a count of the number of "heads" in a "n"-flip experiment.
            optpath.add(sum_d_heads[k] == sum_heads)

            # w(i) * x(i) term for expectataion.
            optpath.add(expected_heads[k] == path_prob_sym_vars[k] * sum_d_heads[k])
            # optpath.add(expected_heads[k] == expected_heads_run)

            # Display progress bar
            executeBar()

    # E[heads] for all "k" terms = sum(expected_heads) = sum(w(i) * x(i))
    # Sum over the "k" expected heads terms.
    optpath.add(sum_of_k == z3.Sum(expected_heads))

    # Sigma(w(i)) value
    optpath.add(sigma_w_i == z3.Sum(path_prob_sym_vars))
    # optpath.add(z3.And(sigma_w_i >= 0, sigma_w_i <= n_iters * prob))

    optpath.add(error_mass == (n_iters * prob - sum_of_k))

    # COMMENT : for n-coin flips case,
    # check if the above program violates the assertion :
    # COMMENT : if (prob <= 0.5) E(x) < 0.4 * n else E(x) >= 0.6 * n
    # '1' indicates, assert Violation.
    optpath.add(
        assert_violated
        == z3.If(
            probability_factor <= 0.50,
            z3.If(sum_of_k < 0.40 * n_iters, 0, 1),
            z3.If(sum_of_k >= 0.60 * n_iters, 0, 1),
        )
    )

    # Two vectors d1 & d2 must be distinct
    # ForAll([i, j], vec(d[i]) != vec(d[j])))
    # COMMENT : Is there a better way to do it using uninterpreted functions?
    # COMMENT : Extremely Expensive
    for i in range(candidatePaths):
        for j in range(candidatePaths):
            if i > j:
                optpath.add(
                    z3.Not(
                        z3.And(
                            [
                                (d_sym_vars[i][k] == d_sym_vars[j][k])
                                for k in range(n_iters)
                            ]
                        )
                    )
                )
            else:
                break

    print("[Opt] Solving for Optimal Solution.")

    # COMMENT : Assert Violation Case
    # COMMENT : Set some probability limits
    # optpath.add(probability_factor > 0)
    # optpath.add(probability_factor <= 0.50)
    # optpath.add(z3.Not(sum_of_k < 0.40 * n_iters))

    optpath.maximize(sigma_w_i)
    # optpath.maximize(sum_of_k)
    # optpath.minimize(error_mass)

    # for k in range(candidatePaths):
    #     optpath.maximize(path_prob_sym_vars[k])

    # print(optpath.assertions())
    print(optpath.check())
    m = optpath.model()

    model_dict = {}
    for d in m.decls():
        model_dict[d.name()] = get_value(m[d])

    with open(sys.argv[5], mode="w") as file:
        json.dump(model_dict, file, indent=2)

    # TODO : Heat Map -> x : different "k" values, y : different "prob" values.
    # TODO : value(x, y) : | n * prob - (value from model i.e sum(expected_heads[k])) |


if __name__ == "__main__":
    # k : models needed in sum term, n : iterations (n-coin flips), prob : probability value.
    generateCandidates(int(sys.argv[1]), int(sys.argv[2]), float(sys.argv[3]))
