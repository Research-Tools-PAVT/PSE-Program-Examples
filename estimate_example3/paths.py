import z3

b_sym, c_prob_sym, d_prob_sym, a_sym = z3.Ints(
    "b_sym c_prob_sym d_prob_sym a_sym")

path1 = [
    (0 <= b_sym),
    (b_sym <= 20),
    (0 <= c_prob_sym),
    (c_prob_sym <= 800),
    (0 <= d_prob_sym),
    (d_prob_sym <= 650),
    (b_sym < a_sym)
]

path2 = [
    (0 <= b_sym),
    (b_sym <= 20),
    (0 <= c_prob_sym),
    (c_prob_sym <= 800),
    (0 <= d_prob_sym),
    (d_prob_sym <= 650),
    z3.Not((b_sym < a_sym)),
    z3.Not((d_prob_sym < c_prob_sym))
]

path3 = [
    (0 <= b_sym),
    (b_sym <= 20),
    (0 <= c_prob_sym),
    (c_prob_sym <= 800),
    (0 <= d_prob_sym),
    (d_prob_sym <= 650),
    z3.Not((b_sym < a_sym)),
    (d_prob_sym < c_prob_sym),
    z3.And((0 <= a_sym), (0 <= b_sym))
]

path4 = [
    (0 <= b_sym),
    (b_sym <= 20),
    (0 <= c_prob_sym),
    (c_prob_sym <= 800),
    (0 <= d_prob_sym),
    (d_prob_sym <= 650),
    z3.Not((b_sym < a_sym)),
    (d_prob_sym < c_prob_sym),
    z3.Not(z3.And((0 <= a_sym), (0 <= b_sym))),
    (0 < (a_sym * 3))
]

path5 = [
    (0 <= b_sym),
    (b_sym <= 20),
    (0 <= c_prob_sym),
    (c_prob_sym <= 800),
    (0 <= d_prob_sym),
    (d_prob_sym <= 650),
    z3.Not((b_sym < a_sym)),
    (d_prob_sym < c_prob_sym),
    z3.Not(z3.And((0 <= a_sym), (0 <= b_sym))),
    z3.Not((0 < (a_sym * 3)))
]


paths = [path1, path2, path3, path4, path5]
