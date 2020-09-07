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
S.add(Exists([x, y], P1(x, y) * q1(x, y) > 0.5))

print(S.check())
print(S.model())
print(S.sexpr())

"""
Model :
[p1 = [(0, 2) -> 1, (3, 4) -> 1, else -> 0],
 p2 = [(0, 2) -> 1, else -> 0],
 q2 = [else -> 1],
 q1 = [(0, 2) -> 0, else -> 1]]
"""

"""
(set-logic ALL)
(set-option :produce-models true)
(declare-fun p1 (Int Int) Int)
(declare-fun p2 (Int Int) Int)
(declare-fun q1 (Int Int) Real)
(declare-fun q2 (Int Int) Real)
(assert (forall ((x Int) (y Int)) (or (= (p1 x y) 0) (= (p1 x y) 1))))
(assert (forall ((x Int) (y Int)) (or (= (p2 x y) 0) (= (p2 x y) 1))))
(assert (forall ((x Int) (y Int)) (or (>= (q1 x y) 0.0) (<= (q1 x y) 1.0))))
(assert (forall ((x Int) (y Int)) (or (>= (q2 x y) 0.0) (<= (q2 x y) 1.0))))
(assert (exists ((x Int) (y Int))
  (let ((a!1 (+ (* (to_real (p1 x y)) (q1 x y)) (* (to_real (p2 x y)) (q2 x y)))))
    (> a!1 (/ 1.0 2.0)))))
(assert (exists ((x Int) (y Int)) (> (* (to_real (p1 x y)) (q1 x y)) (/ 1.0 2.0))))
(get-model)
"""
