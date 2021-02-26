import z3

"""
Trying a manual example here.
    "(Sle 0 (ReadLSB w32 0 d_prob_sym))",
    "(Sle (ReadLSB w32 0 d_prob_sym) 650)",
    "(Slt 50 (ReadLSB w32 0 a_sym))",
    "(Eq false (Slt 60 (ReadLSB w32 0 d_prob_sym)))",
    "(Eq false (Slt (ReadLSB w32 0 d_prob_sym) (Add w32 75 (ReadLSB w32 0 a_sym))))"
"""


def generateCandidates(k: int):
    opt = z3.Optimize()
    a = z3.Int("a_sym")
    d = z3.Int("d_prob_sym")

    opt.add(d >= 0)
    opt.add(d <= 650)
    opt.add(a > 50)
    opt.add(z3.Not(d > 60))
    opt.add(a + 75 > d)

    # Need to Check this.
    opt.maximize(a - d - 75)

    n = 0
    while opt.check() == z3.sat and n != k:
        m = opt.model()
        n += 1
        print("%s = %s" % (a, m[a]))
        print("%s = %s" % (d, m[d]))
        opt.add(z3.Or(a != m[a]))


if __name__ == "__main__":
    generateCandidates(15)
