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
[p1 = [(2, 3) -> 1, (4, 5) -> 1, else -> 0],
 p2 = [else -> 0],
 q2 = [else -> 0],
 q1 = [else ->
       If(And(Var(0) == 4, Not(Var(1) == 5)),
          0,
          If(And(Not(Var(0) == 4), Var(1) == 5),
             0,
             If(And(Var(0) == 4, Var(1) == 5),
                1,
                If(And(Not(Var(0) == 4), Not(Var(1) == 5)),
                   1,
                   7))))]]
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
(assert (forall ((x Int) (y Int)) (and (>= (q1 x y) 0.0) (<= (q1 x y) 1.0))))
(assert (forall ((x Int) (y Int)) (and (>= (q2 x y) 0.0) (<= (q2 x y) 1.0))))
(assert (exists ((x Int) (y Int))
  (let ((a!1 (+ (* (to_real (p1 x y)) (q1 x y)) (* (to_real (p2 x y)) (q2 x y)))))
    (> a!1 (/ 1.0 2.0)))))
(assert (exists ((x Int) (y Int)) (> (* (to_real (p1 x y)) (q1 x y)) (/ 1.0 2.0))))
(rmodel->model-converter-wrapper
x!1 -> 2
x!3 -> 4
y!0 -> 3
y!2 -> 5
p1 -> {
  2 3 -> 1
  4 5 -> 1
  else -> 0
}
p2 -> {
  0
}
q2 -> {
  (q2!36 (k!35 (:var 0)) (k!34 (:var 1)))
}
k!33 -> {
  4 -> 4
  else -> 2
}
k!35 -> {
  2
}
q1!37 -> {
  2 3 -> 1.0
  4 5 -> 1.0
  2 5 -> 0.0
  4 3 -> 0.0
  else -> 7.0
}
k!32 -> {
  5 -> 5
  else -> 3
}
q2!36 -> {
  2 3 -> 0.0
  else -> 6.0
}
q1 -> {
  (q1!37 (k!33 (:var 0)) (k!32 (:var 1)))
}
k!34 -> {
  3
}
)
"""
