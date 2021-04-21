import z3

z_sym, prob_sym, flip_pse_sym = z3.Ints("z_sym prob_sym flip_pse_sym")

path1 = [
    (0 <= z_sym),
    (flip_pse_sym <= 1),
    (0 <= prob_sym),
    (0 <= flip_pse_sym),
    (prob_sym <= 1),
    flip_pse_sym == 0
]

path2 = [
    (0 <= z_sym),
    (flip_pse_sym <= 1),
    (0 <= prob_sym),
    (0 <= flip_pse_sym),
    (prob_sym <= 1),
    z3.Not(flip_pse_sym == 0)
]


paths = [path1, path2]
