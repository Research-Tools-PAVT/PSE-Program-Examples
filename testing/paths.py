import z3

d_sym, c_sym, a_sym, b_prob_sym, e_prob_sym = z3.Ints(
    "d_sym c_sym a_sym b_prob_sym e_prob_sym")

path1 = [
    (0 <= b_prob_sym),
    (b_prob_sym <= 1),
    (1 <= e_prob_sym),
    (e_prob_sym <= 6),
    (0 <= a_sym),
    (a_sym <= 1),
    (1 <= c_sym),
    (c_sym <= 10),
    (0 <= d_sym),
    (d_sym <= 5),
    (b_prob_sym < a_sym),
    ((e_prob_sym + c_sym) < 15)
]

path2 = [
    (0 <= b_prob_sym),
    (b_prob_sym <= 1),
    (1 <= e_prob_sym),
    (e_prob_sym <= 6),
    (0 <= a_sym),
    (a_sym <= 1),
    (1 <= c_sym),
    (c_sym <= 10),
    (0 <= d_sym),
    (d_sym <= 5),
    (b_prob_sym < a_sym),
    z3.Not(((e_prob_sym + c_sym) < 15))
]

path3 = [
    (0 <= b_prob_sym),
    (b_prob_sym <= 1),
    (1 <= e_prob_sym),
    (e_prob_sym <= 6),
    (0 <= a_sym),
    (a_sym <= 1),
    (1 <= c_sym),
    (c_sym <= 10),
    (0 <= d_sym),
    (d_sym <= 5),
    z3.Not((b_prob_sym < a_sym)),
    (1 < (e_prob_sym + d_sym))
]

path4 = [
    (0 <= b_prob_sym),
    (b_prob_sym <= 1),
    (1 <= e_prob_sym),
    (e_prob_sym <= 6),
    (0 <= a_sym),
    (a_sym <= 1),
    (1 <= c_sym),
    (c_sym <= 10),
    (0 <= d_sym),
    (d_sym <= 5),
    z3.Not((b_prob_sym < a_sym)),
    z3.Not((1 < (e_prob_sym + d_sym)))
]


paths = [path1, path2, path3, path4]
