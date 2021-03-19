import z3

a_sym, c_sym, b_sym = z3.Ints("a_sym c_sym b_sym")

path1 = [
    (90 <= c_sym),
    (c_sym <= 120),
    (0 <= a_sym),
    (a_sym <= 10000),
    (0 <= b_sym),
    (b_sym <= 10000),
    z3.Not(z3.And((0 < a_sym), (0 < c_sym))),
    ((b_sym + a_sym) < c_sym)
]

path2 = [
    (90 <= c_sym),
    (c_sym <= 120),
    (0 <= a_sym),
    (a_sym <= 10000),
    (0 <= b_sym),
    (b_sym <= 10000),
    z3.Not(z3.And((0 < a_sym), (0 < c_sym))),
    z3.Not(((b_sym + a_sym) < c_sym))
]

path3 = [
    (90 <= c_sym),
    (c_sym <= 120),
    (0 <= a_sym),
    (a_sym <= 10000),
    (0 <= b_sym),
    (b_sym <= 10000),
    z3.And((0 < a_sym), (0 < c_sym)),
    ((b_sym + a_sym) < c_sym)
]

path4 = [
    (90 <= c_sym),
    (c_sym <= 120),
    (0 <= a_sym),
    (a_sym <= 10000),
    (0 <= b_sym),
    (b_sym <= 10000),
    z3.And((0 < a_sym), (0 < c_sym)),
    z3.Not(((b_sym + a_sym) < c_sym))
]


paths = [path1, path2, path3, path4]
