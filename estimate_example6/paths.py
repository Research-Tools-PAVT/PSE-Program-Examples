import z3

i_sym, prob_sym = z3.Ints("i_sym prob_sym")

path1 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    (i_sym < 20),
    z3.Not(((i_sym + 1) < 20)),
]

path2 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    z3.Not((i_sym < 20)),
    z3.Not(((i_sym + 2) < 20)),
]

path3 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    z3.Not((i_sym < 20)),
    ((i_sym + 2) < 20),
    z3.Not(((i_sym + 4) < 20)),
]

path4 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    (i_sym < 20),
    ((i_sym + 1) < 20),
    z3.Not(((i_sym + 3) < 20)),
]

path5 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    (i_sym < 20),
    ((i_sym + 1) < 20),
    ((i_sym + 3) < 20),
    z3.Not(((i_sym + 5) < 20)),
]

path6 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    z3.Not((i_sym < 20)),
    ((i_sym + 2) < 20),
    ((i_sym + 4) < 20),
    z3.Not(((i_sym + 6) < 20)),
]

path7 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    (i_sym < 20),
    ((i_sym + 1) < 20),
    ((i_sym + 3) < 20),
    ((i_sym + 5) < 20),
    z3.Not(((i_sym + 7) < 20)),
]

path8 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    z3.Not((i_sym < 20)),
    ((i_sym + 2) < 20),
    ((i_sym + 4) < 20),
    ((i_sym + 6) < 20),
    z3.Not(((i_sym + 8) < 20)),
]

path9 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    (i_sym < 20),
    ((i_sym + 1) < 20),
    ((i_sym + 3) < 20),
    ((i_sym + 5) < 20),
    ((i_sym + 7) < 20),
    z3.Not(((i_sym + 9) < 20)),
]

path10 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    z3.Not((i_sym < 20)),
    ((i_sym + 2) < 20),
    ((i_sym + 4) < 20),
    ((i_sym + 6) < 20),
    ((i_sym + 8) < 20),
    z3.Not(((i_sym + 10) < 20)),
]

path11 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    (i_sym < 20),
    ((i_sym + 1) < 20),
    ((i_sym + 3) < 20),
    ((i_sym + 5) < 20),
    ((i_sym + 7) < 20),
    ((i_sym + 9) < 20),
    z3.Not(((i_sym + 11) < 20)),
]

path12 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    z3.Not((i_sym < 20)),
    ((i_sym + 2) < 20),
    ((i_sym + 4) < 20),
    ((i_sym + 6) < 20),
    ((i_sym + 8) < 20),
    ((i_sym + 10) < 20),
    z3.Not(((i_sym + 12) < 20)),
]

path13 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    (i_sym < 20),
    ((i_sym + 1) < 20),
    ((i_sym + 3) < 20),
    ((i_sym + 5) < 20),
    ((i_sym + 7) < 20),
    ((i_sym + 9) < 20),
    ((i_sym + 11) < 20),
    z3.Not(((i_sym + 13) < 20)),
]

path14 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    z3.Not((i_sym < 20)),
    ((i_sym + 2) < 20),
    ((i_sym + 4) < 20),
    ((i_sym + 6) < 20),
    ((i_sym + 8) < 20),
    ((i_sym + 10) < 20),
    ((i_sym + 12) < 20),
    z3.Not(((i_sym + 14) < 20)),
]

path15 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    (i_sym < 20),
    ((i_sym + 1) < 20),
    ((i_sym + 3) < 20),
    ((i_sym + 5) < 20),
    ((i_sym + 7) < 20),
    ((i_sym + 9) < 20),
    ((i_sym + 11) < 20),
    ((i_sym + 13) < 20),
    z3.Not(((i_sym + 15) < 20)),
]

path16 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    z3.Not((i_sym < 20)),
    ((i_sym + 2) < 20),
    ((i_sym + 4) < 20),
    ((i_sym + 6) < 20),
    ((i_sym + 8) < 20),
    ((i_sym + 10) < 20),
    ((i_sym + 12) < 20),
    ((i_sym + 14) < 20),
    ((i_sym + 16) < 20),
]

path17 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    z3.Not((i_sym < 20)),
    ((i_sym + 2) < 20),
    ((i_sym + 4) < 20),
    ((i_sym + 6) < 20),
    ((i_sym + 8) < 20),
    ((i_sym + 10) < 20),
    ((i_sym + 12) < 20),
    ((i_sym + 14) < 20),
    z3.Not(((i_sym + 16) < 20)),
]

path18 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    (i_sym < 20),
    ((i_sym + 1) < 20),
    ((i_sym + 3) < 20),
    ((i_sym + 5) < 20),
    ((i_sym + 7) < 20),
    ((i_sym + 9) < 20),
    ((i_sym + 11) < 20),
    ((i_sym + 13) < 20),
    ((i_sym + 15) < 20),
    z3.Not(((i_sym + 17) < 20)),
]

path19 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    (i_sym < 20),
    z3.Not((i_sym % 2) == 0),
    ((i_sym + 1) < 20),
    ((i_sym + 3) < 20),
    ((i_sym + 5) < 20),
    ((i_sym + 7) < 20),
    ((i_sym + 9) < 20),
    ((i_sym + 11) < 20),
    ((i_sym + 13) < 20),
    ((i_sym + 15) < 20),
    ((i_sym + 17) < 20),
]

path20 = [
    (0 <= prob_sym),
    (1 <= i_sym),
    (prob_sym <= 1),
    (i_sym <= 20),
    (i_sym < 20),
    (i_sym % 2) == 0,
    ((i_sym + 1) < 20),
    ((i_sym + 3) < 20),
    ((i_sym + 5) < 20),
    ((i_sym + 7) < 20),
    ((i_sym + 9) < 20),
    ((i_sym + 11) < 20),
    ((i_sym + 13) < 20),
    ((i_sym + 15) < 20),
    ((i_sym + 17) < 20),
]


paths = [
    path1,
    path2,
    path3,
    path4,
    path5,
    path6,
    path7,
    path8,
    path9,
    path10,
    path11,
    path12,
    path13,
    path14,
    path15,
    path16,
    path17,
    path18,
    path19,
    path20,
]
