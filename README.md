# PSE Project (KLEE Modifications) 

We present two new functions one for declaring a ```probabilistic``` variable and the other for getting a ```KLEE KQuery``` dump 
for a given variable, this can later be extended to get all ```valid KQuery``` expressions in the ```Constraint Set``` processed so far in the execution path. 

- ```klee_make_pse_symbolic(&a, sizeof(a), "a_pse_sym", _distribution, _probabilities)```, the last two are float* (arrays).
- ```klee_dump_kquery_state()```, KQuery Dump for a given state (current state of execution). Extended it ot give KQuery Dump for all states that belong to a particular path.
- ```klee_dump_symbolic_details(&a, "a")```, for KQuery dump of variable. 

## Variable Types : 

| Variable Type 	| Output (make_symbolic_name)	| Distribution Vector @init 	| Probability Vector @init 	|
|-	|-	|-	|-	|
| ```ForAll Vars``` 	| Yes 	| No 	| No 	|
| ```Non-det Vars``` 	| Yes 	| Yes 	| No 	|
| ```Probabilistic Vars``` 	| Yes 	| Yes 	| Yes 	|

The sample code below explain the use accordingly.

- When ever a new ```PSE Variable``` is created using ```klee_make_pse_symbolic()```, it prints the exact type of the variable 
as per the table shown above. 

- For ```KQuery``` dump, we see the ```KQuery``` & ```SMTLIB2``` constraints for the current ExecutionState in the path explored. The output is in a file ```kquery_dump.txt```, where the constraints are dumped tagged by the location of the instruction for ```klee_dump_kquery_state()``` in the code file. This function now dumps for all states in the path for both ```kquery``` and ```smtlib2``` format.

# PSE Project Examples

Probabilistic Symbolic Execution using KLEE, LLVM and Z3. 
Replaying is a way to check the the testcase produced by KLEE for a given program, by running it concretely on the program. 
For each complete path taken by KLEE, it generates one testcase containing the values of the ```variables``` marked ```symbolic```.

## Replay for Example-1

```bash
KLEE: output directory is "/home/mlc655/Documents/PSE-Program-Examples/klee-out-0"
KLEE: Using Z3 solver backend
KLEE: PSE Message: Created Probabilistic Variable
KLEE: PSE Message: Created Probabilistic Variable

KLEE: done: total instructions = 1197
KLEE: done: completed paths = 2
KLEE: done: generated tests = 2
ktest file : 'klee-last/test000001.ktest'
args       : ['example1.bc']
num objects: 3
object 0: name: 'a_pse_sym'
object 0: size: 4
object 0: data: b'\x00\x00\x00\x00'
object 0: hex : 0x00000000
object 0: int : 0
object 0: uint: 0
object 0: text: ....
object 1: name: 'b_pse_sym'
object 1: size: 4
object 1: data: b'\x00\x00\x00\x00'
object 1: hex : 0x00000000
object 1: int : 0
object 1: uint: 0
object 1: text: ....
object 2: name: 'c_sym'
object 2: size: 4
object 2: data: b'\x00\x00\x00\x00'
object 2: hex : 0x00000000
object 2: int : 0
object 2: uint: 0
object 2: text: ....
255
```

## Replay for Example-2

```bash
KLEE: output directory is "/home/mlc655/Documents/PSE-Program-Examples/klee-out-0"
KLEE: Using Z3 solver backend
KLEE: PSE Message: Created Probabilistic Variable
KLEE: PSE Message: Created Probabilistic Variable
KLEE: ERROR: example2.cpp:32: ASSERTION FAIL: a > b
KLEE: NOTE: now ignoring this error at this location
KLEE: ERROR: example2.cpp:44: ASSERTION FAIL: b >= a
KLEE: NOTE: now ignoring this error at this location

KLEE: done: total instructions = 1091
KLEE: done: completed paths = 5
KLEE: done: generated tests = 5
ktest file : 'klee-last/test000001.ktest'
args       : ['example2.bc']
num objects: 3
object 0: name: 'a_pse_sym'
object 0: size: 4
object 0: data: b'\x00\x00\x00\x00'
object 0: hex : 0x00000000
object 0: int : 0
object 0: uint: 0
object 0: text: ....
object 1: name: 'b_pse_sym'
object 1: size: 4
object 1: data: b'\x00\x00\x00\x00'
object 1: hex : 0x00000000
object 1: int : 0
object 1: uint: 0
object 1: text: ....
object 2: name: 'c_sym'
object 2: size: 4
object 2: data: b'\x00\x00\x00\x00'
object 2: hex : 0x00000000
object 2: int : 0
object 2: uint: 0
object 2: text: ....
0
```

## Replay for Example-3

```bash
KLEE: output directory is "/home/mlc655/Documents/PSE-Program-Examples/klee-out-0"
KLEE: Using Z3 solver backend
KLEE: PSE Message: Created Probabilistic Variable
KLEE: PSE Message: Created Probabilistic Variable

KLEE: done: total instructions = 1093
KLEE: done: completed paths = 3
KLEE: done: generated tests = 3
ktest file : 'klee-last/test000001.ktest'
args       : ['example3.bc']
num objects: 3
object 0: name: 'a_pse_sym'
object 0: size: 4
object 0: data: b'\x00\x00\x00\x00'
object 0: hex : 0x00000000
object 0: int : 0
object 0: uint: 0
object 0: text: ....
object 1: name: 'b_pse_sym'
object 1: size: 4
object 1: data: b'\x00\x00\x00\x00'
object 1: hex : 0x00000000
object 1: int : 0
object 1: uint: 0
object 1: text: ....
object 2: name: 'c_sym'
object 2: size: 4
object 2: data: b'\x00\x00\x00\x00'
object 2: hex : 0x00000000
object 2: int : 0
object 2: uint: 0
object 2: text: ....
0
```

## Replay for MontyHall 

```bash
KLEE: output directory is "/home/mlc655/Documents/PSE-Program-Examples/klee-out-0"
KLEE: Using Z3 solver backend
KLEE: PSE Message: Created Probabilistic Variable
KLEE: PSE Message: Created Probabilistic Variable

KLEE: done: total instructions = 427
KLEE: done: completed paths = 9
KLEE: done: generated tests = 9
ktest file : 'klee-last/test000001.ktest'
args       : ['montyhall.bc']
num objects: 4
object 0: name: 'door_switch_pse_var_sym'
object 0: size: 1
object 0: data: b'\x00'
object 0: hex : 0x00
object 0: int : 0
object 0: uint: 0
object 0: text: .
object 1: name: 'choice_pse_var_sym'
object 1: size: 4
object 1: data: b'\x00\x00\x00\x00'
object 1: hex : 0x00000000
object 1: int : 0
object 1: uint: 0
object 1: text: ....
object 2: name: 'car_door_sym'
object 2: size: 4
object 2: data: b'\x00\x00\x00\x00'
object 2: hex : 0x00000000
object 2: int : 0
object 2: uint: 0
object 2: text: ....
object 3: name: 'host_door_sym'
object 3: size: 4
object 3: data: b'\x00\x00\x00\x00'
object 3: hex : 0x00000000
object 3: int : 0
object 3: uint: 0
object 3: text: ....
1
```


