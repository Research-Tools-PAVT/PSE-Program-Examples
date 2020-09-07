# -*- coding: utf-8 -*-
from z3 import *

P1 = Function("p1", IntSort(), IntSort(), IntSort())
P2 = Function("p2", IntSort(), IntSort(), IntSort())

q1 = Function("q1", IntSort(), RealSort())
q2 = Function("q2", IntSort(), RealSort())

x = Int('x')
y = Int('y')
choice = Int('choice')

S = Solver()

S.add(ForAll([x, y], Or(P1(x, y) == 0, P1(x, y) == 1)))
S.add(ForAll([x, y], Or(P2(x, y) == 0, P2(x, y) == 1)))
S.add(ForAll([choice], And(q1(choice) >= 0, q1(choice) <= 1)))
S.add(ForAll([choice], And(q2(choice) >= 0, q2(choice) <= 1)))

"""
TODO : Encode this ==> Probability q(choice) = 1/3 * [choice != 1] 
TODO : Encode this ==> Probability q(choice) = 1/3 * [choice != 1] + 0 * [choice == 1]
"""
S.add(Exists([x, y, choice], P1(x, y) * q1(choice) > 0.5))

print(S.check())
print(S.model())
print(S.sexpr())

"""
Model : 
[p1 = [(3, 4) -> 1, else -> 0],
 p2 = [else -> 0],
 q1 = [else -> 1],
 q2 = [else -> 0]]
"""

"""
(declare-fun p1 (Int Int) Int)
(declare-fun p2 (Int Int) Int)
(declare-fun q1 (Int) Real)
(declare-fun q2 (Int) Real)
(assert (forall ((x Int) (y Int)) (or (= (p1 x y) 0) (= (p1 x y) 1))))
(assert (forall ((x Int) (y Int)) (or (= (p2 x y) 0) (= (p2 x y) 1))))
(assert (forall ((choice Int)) (and (>= (q1 choice) 0.0) (<= (q1 choice) 1.0))))
(assert (forall ((choice Int)) (and (>= (q2 choice) 0.0) (<= (q2 choice) 1.0))))
(assert (exists ((x Int) (y Int) (choice Int))
  (> (* (to_real (p1 x y)) (q1 choice)) (/ 1.0 2.0))))
(rmodel->model-converter-wrapper
choice!0 -> 0
x!2 -> 3
y!1 -> 4
p1 -> {
  3 4 -> 1
  else -> 0
}
p2 -> {
  0
}
q1 -> {
  (q1!14 (k!12 (:var 0)))
}
k!12 -> {
  0
}
q2 -> {
  (q2!15 (k!13 (:var 0)))
}
q1!14 -> {
  0 -> 1.0
  else -> 2.0
}
q2!15 -> {
  2 -> 0.0
  else -> 3.0
}
k!13 -> {
  2
}
)
"""
