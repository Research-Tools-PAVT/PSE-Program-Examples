import z3

n_sym, y_sym, prob_sym = z3.Ints("n_sym y_sym prob_sym")

path1 = [
    (0 <= prob_sym),
    (0 <= y_sym),
    (prob_sym <= 1),
    (1 <= n_sym)
]

path2 = [
    (0 <= prob_sym),
    (0 <= y_sym),
    (prob_sym <= 1),
    z3.Not((1 <= n_sym)),
    z3.Not((0 < (n_sym + 4294967295)))
]

path3 = [
    (0 <= prob_sym),
    (0 <= y_sym),
    (prob_sym <= 1),
    z3.Not((1 <= n_sym)),
    (0 < (n_sym + 4294967295)),
    z3.Not((0 < (n_sym + 4294967294)))
]

path4 = [
    (0 <= prob_sym),
    (0 <= y_sym),
    (prob_sym <= 1),
    z3.Not((1 <= n_sym)),
    (0 < (n_sym + 4294967295)),
    (0 < (n_sym + 4294967294)),
    z3.Not((0 < (n_sym + 4294967293)))
]

path5 = [
    (0 <= prob_sym),
    (0 <= y_sym),
    (prob_sym <= 1),
    z3.Not((1 <= n_sym)),
    (0 < (n_sym + 4294967295)),
    (0 < (n_sym + 4294967294)),
    (0 < (n_sym + 4294967293)),
    z3.Not((0 < (n_sym + 4294967292)))
]

path6 = [
    (0 <= prob_sym),
    (0 <= y_sym),
    (prob_sym <= 1),
    z3.Not((1 <= n_sym)),
    (0 < (n_sym + 4294967295)),
    (0 < (n_sym + 4294967294)),
    (0 < (n_sym + 4294967293)),
    (0 < (n_sym + 4294967292)),
    z3.Not((0 < (n_sym + 4294967291)))
]

path7 = [
    (0 <= prob_sym),
    (0 <= y_sym),
    (prob_sym <= 1),
    z3.Not((1 <= n_sym)),
    (0 < (n_sym + 4294967295)),
    (0 < (n_sym + 4294967294)),
    (0 < (n_sym + 4294967293)),
    (0 < (n_sym + 4294967292)),
    (0 < (n_sym + 4294967291)),
    z3.Not((0 < (n_sym + 4294967290)))
]

path8 = [
    (0 <= prob_sym),
    (0 <= y_sym),
    (prob_sym <= 1),
    z3.Not((1 <= n_sym)),
    (0 < (n_sym + 4294967295)),
    (0 < (n_sym + 4294967294)),
    (0 < (n_sym + 4294967293)),
    (0 < (n_sym + 4294967292)),
    (0 < (n_sym + 4294967291)),
    (0 < (n_sym + 4294967290)),
    z3.Not((0 < (n_sym + 4294967289)))
]

path9 = [
    (0 <= prob_sym),
    (0 <= y_sym),
    (prob_sym <= 1),
    z3.Not((1 <= n_sym)),
    (0 < (n_sym + 4294967295)),
    (0 < (n_sym + 4294967294)),
    (0 < (n_sym + 4294967293)),
    (0 < (n_sym + 4294967292)),
    (0 < (n_sym + 4294967291)),
    (0 < (n_sym + 4294967290)),
    (0 < (n_sym + 4294967289)),
    z3.Not((0 < (n_sym + 4294967288)))
]

path10 = [
    (0 <= prob_sym),
    (0 <= y_sym),
    (prob_sym <= 1),
    z3.Not((1 <= n_sym)),
    (0 < (n_sym + 4294967295)),
    (0 < (n_sym + 4294967294)),
    (0 < (n_sym + 4294967293)),
    (0 < (n_sym + 4294967292)),
    (0 < (n_sym + 4294967291)),
    (0 < (n_sym + 4294967290)),
    (0 < (n_sym + 4294967289)),
    (0 < (n_sym + 4294967288)),
    (0 < (n_sym + 4294967287))
]

path11 = [
    (0 <= prob_sym),
    (0 <= y_sym),
    (prob_sym <= 1),
    z3.Not((1 <= n_sym)),
    (0 < (n_sym + 4294967295)),
    (0 < (n_sym + 4294967294)),
    (0 < (n_sym + 4294967293)),
    (0 < (n_sym + 4294967292)),
    (0 < (n_sym + 4294967291)),
    (0 < (n_sym + 4294967290)),
    (0 < (n_sym + 4294967289)),
    (0 < (n_sym + 4294967288)),
    z3.Not((0 < (n_sym + 4294967287)))
]


paths = [path1, path2, path3, path4, path5,
         path6, path7, path8, path9, path10, path11]
