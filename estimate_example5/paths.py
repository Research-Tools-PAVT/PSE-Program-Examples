import z3

n_sym, y_sym = z3.Ints("n_sym y_sym")
prob_sym = z3.Real("prob_sym")

path1 = [
    (1 <= n_sym),
    (0 <= y_sym),
    (0 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    z3.Not((1 < n_sym)),
]

path2 = [
    (1 <= n_sym),
    (0 <= y_sym),
    (0 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    z3.Not((2 < n_sym)),
]

path3 = [
    (1 <= n_sym),
    (0 <= y_sym),
    (0 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    (2 < n_sym),
    z3.Not((3 < n_sym)),
]

path4 = [
    (1 <= n_sym),
    (0 <= y_sym),
    (0 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    (2 < n_sym),
    (3 < n_sym),
    z3.Not((4 < n_sym)),
]

path5 = [
    (1 <= n_sym),
    (0 <= y_sym),
    (0 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    (2 < n_sym),
    (3 < n_sym),
    (4 < n_sym),
    z3.Not((5 < n_sym)),
]

path6 = [
    (1 <= n_sym),
    (0 <= y_sym),
    (0 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    (2 < n_sym),
    (3 < n_sym),
    (4 < n_sym),
    (5 < n_sym),
    z3.Not((6 < n_sym)),
]

path7 = [
    (1 <= n_sym),
    (0 <= y_sym),
    (0 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    (2 < n_sym),
    (3 < n_sym),
    (4 < n_sym),
    (5 < n_sym),
    (6 < n_sym),
    z3.Not((7 < n_sym)),
]

path8 = [
    (1 <= n_sym),
    (0 <= y_sym),
    (0 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    (2 < n_sym),
    (3 < n_sym),
    (4 < n_sym),
    (5 < n_sym),
    (6 < n_sym),
    (7 < n_sym),
    z3.Not((8 < n_sym)),
]

path9 = [
    (1 <= n_sym),
    (0 <= y_sym),
    (0 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    (2 < n_sym),
    (3 < n_sym),
    (4 < n_sym),
    (5 < n_sym),
    (6 < n_sym),
    (7 < n_sym),
    (8 < n_sym),
    (9 < n_sym),
]

path10 = [
    (1 <= n_sym),
    (0 <= y_sym),
    (0 <= prob_sym),
    (prob_sym <= 1),
    (n_sym <= 10),
    (1 < n_sym),
    (2 < n_sym),
    (3 < n_sym),
    (4 < n_sym),
    (5 < n_sym),
    (6 < n_sym),
    (7 < n_sym),
    (8 < n_sym),
    z3.Not((9 < n_sym)),
]


paths = [path1, path2, path3, path4, path5, path6, path7, path8, path9, path10]
