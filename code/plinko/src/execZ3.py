import json
from z3 import *
import sys

if(len(sys.argv) != 3):
    print("Usage: execZ3 path_to_SMTLIB_probs path_to_sym_intervals")
    exit(-1)

probsPath  = sys.argv[1]
symIntPath = sys.argv[2]

ctx = Context()
x = Real('x',ctx)
rand_sym = BitVec('rand_sym', 32, ctx)
retval = BitVec('retval', 32, ctx)
n = Int('n_sym', ctx)

test = parse_smt2_string("(assert (= x (+ (/ (+ (ite (and (bvslt #x00000005 rand_sym) (= #x00000001 retval)) 1.0 0.0)) (* 1.0 (to_real (* (- n_sym 0))))) (/ (+ (ite (and (= false (bvslt #x00000005 rand_sym)) (= #x00000000 retval)) 1.0 0.0)) (* 1.0 (to_real (* (- n_sym 0))))))))", ctx=ctx, decls={'x' : x, 'rand_sym' : rand_sym, 'retval' : retval, 'n_sym' : n})

curSum = test[0].children()[1]

symSum = RecFunction('symSum', IntSort(ctx), IntSort(ctx), RealSort(ctx))
a = Int('a', ctx)
b = Int('b', ctx)
RecAddDefinition(symSum, [a,b], If(a > b, 0.0, substitute(curSum, (rand_sym, Int2BV(a,32)), (retval, BitVecVal(1,32,ctx))) + symSum(a+1,b)))
total = Real('total',ctx)
s = Solver(ctx=ctx)
s.add(n >= 5)
s.add(symSum(0,n) != ((ToReal(n)-5)/ToReal(n)))
# s.add(n>=5)
# s.add(retval == BitVecVal(1,32,ctx))
# s.add(simplify(symSum(0,n)) == total)
# s.add(total != ((ToReal(n)-5)/ToReal(n)))
# s.add(total < 1.0)
#s.add(total != ((ToReal(n)-5)/ToReal(n)))
print(s.check())
print(s.model())

#with open(probsPath, "r") as fp:
#ctx = Context()
#s = Solver(ctx=ctx)
#probs = parse_smt2_file(probsPath, ctx=ctx)
#print(probs.sort())
    # with open(symIntPath, "r", encoding="utf-8") as fi:
    #     symInts = json.load(fi)
    #     print(symInts)
    

