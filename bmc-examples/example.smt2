;(set-option :opt.priority box)
;(set-option :opt.priority pareto)
(set-option :opt.priority lex)

(declare-const x Int)
(declare-const y Int)

(assert (<= 0 x 10))
(assert (<= 0 y 10))

(assert (not (= x y)))

(maximize (- x y))
(minimize (+ x y))

(check-sat)
(get-model)