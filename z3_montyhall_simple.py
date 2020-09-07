# -*- coding: utf-8 -*-
from z3 import *

P1 = Function("p1", IntSort(), IntSort(), IntSort())
P2 = Function("p2", IntSort(), IntSort(), IntSort())

q1 = Function("q1", IntSort(), IntSort(), RealSort())
q2 = Function("q2", IntSort(), IntSort(), RealSort())

x = Int('x')
y = Int('y')

S = Solver()

S.add(ForAll([x, y], Or(P1(x, y) == 0, P1(x, y) == 1)))
S.add(ForAll([x, y], Or(P2(x, y) == 0, P2(x, y) == 1)))
S.add(ForAll([x, y], And(q1(x, y) >= 0, q1(x, y) <= 1)))
S.add(ForAll([x, y], And(q2(x, y) >= 0, q2(x, y) <= 1)))

S.add(Exists([x, y], P1(x, y) * q1(x, y) + P2(x, y) * q2(x, y) > 0.5))

print(S.check())
print(S.model())
