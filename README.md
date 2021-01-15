# Probabilistic Symbolic Execution 

We present two new functions one for declaring a ```probabilistic``` variable and the other for getting a ```KLEE KQuery``` dump 
for a given variable, this can later be extended to get all ```Valid KQuery``` expressions in the ```Constraint Set``` processed so far in the execution path. 

### Modified KLEE Repository : 

Clone & Build [KLEE](http://klee.github.io/build-llvm9/).

- [KLEE - Symbolic Tree](https://github.com/lahiri-phdworks/klee/tree/symbolic_tree)

#### Functions Added : 

- ```make_pse_symbolic(void *addr, size_t bytes, const char *name, T &&min_elem, T &&max_elem)``` is the function that defines a ```probabilistic``` variable ```addr``` (pass by reference) with ```symbolic``` name ```name``` taking uniform distribution values from ```min_elem``` to ```max_elem``` range. 

- ```klee_dump_kquery_state()``` gives the dump of the ```constraints``` at a state encountered at that program point (invoke point) in ```kquery_dump.txt``` file in the corresponding ```klee_out``` folder of the test case. 

- ```klee_dump_symbolic_details(void *var_name, const char *name)``` gives the symbolic constraint of the program variable (pass a reference) ```var_name``` of the program and prints the dump under ```name``` tag in ```kquery_dump.txt``` file in the corresponding ```klee_out``` folder of the test case. 

#### `KQuery Expression` are s-expressions based on KLEE Kleaver expressions : 

[KQuery Reference](https://klee.github.io/docs/kquery/)

## Python3 Dependencies 

- Install [`python3`](https://www.python.org/downloads/release/python-387/) & [`pip3`](https://www.educative.io/edpresso/installing-pip3-in-ubuntu). 
- Standard Packages : ```re```, ```sys```, ```os```.
- ```graphviz``` (https://pypi.org/project/graphviz/).
- ```sexpdata``` (https://sexpdata.readthedocs.io/en/latest/).
- ```json``` (https://docs.python.org/3/library/json.html).
- ```uuid``` (https://docs.python.org/3/library/uuid.html#example).

## Run Command 

```bash 
$ ./run.sh <path_to_cpp_file>
```

## Running Examples 

```bash 
$ ./run.sh example1
```

```bash 
$ ./run.sh montyhall
```
After processing each test-case, a folder by the name ```_processed``` is build for that particular test case. This is how the ```directory``` structure would look like.

```
├── example1_klee_out
├── example1_processed
├── example2_klee_out
├── example2_processed
├── montyhall_klee_out
├── montyhall_processed
├── run.sh
└── ...
```

## Variable Types : 

| Variable Type 	| Output (make_symbolic_name)	| Distribution Vector @init 	| Probability Vector @init 	|
|-	|-	|-	|-	|
| ```ForAll Vars``` 	| Yes 	| No 	| No 	|
| ```Non-det Vars``` 	| Yes 	| Yes 	| No 	|
| ```Probabilistic Vars``` 	| Yes 	| Yes 	| Yes 	|

The sample code below explain the use accordingly.

- For ```KQuery``` dump, we see the ```KQuery``` & ```SMTLIB2``` constraints for the current ExecutionState in the path explored. The output is in a file ```kquery_dump.txt```, where the constraints are dumped tagged by the location of the instruction for ```klee_dump_kquery_state()``` in the code file. This function now dumps for all states in the path for both ```kquery``` and ```smtlib2``` format.

# Examples 

Probabilistic Symbolic Execution using KLEE, LLVM and Z3. 
Replaying is a way to check the the testcase produced by KLEE for a given program, by running it concretely on the program. 
For each complete path taken by KLEE, it generates one testcase containing the values of the ```variables``` marked ```symbolic```.

## Replay for Example-1

```bash
KLEE: output directory is "/home/mlc6555/Documents/Research/PSE-Program-Examples/klee-out-0"
KLEE: Using Z3 solver backend

KLEE: done: total instructions = 420
KLEE: done: completed paths = 5
KLEE: done: generated tests = 5
ktest file : 'klee-last/test000001.ktest'
args       : ['example1.bc', '--set-ptree-dump']
num objects: 4
object 0: name: 'a_sym'
object 0: size: 4
object 0: data: b'\x00\x00\x00\x80'
object 0: hex : 0x00000080
object 0: int : -2147483648
object 0: uint: 2147483648
object 0: text: ....
object 1: name: 'b_sym'
object 1: size: 4
object 1: data: b'\x00\x00\x00\x00'
object 1: hex : 0x00000000
object 1: int : 0
object 1: uint: 0
object 1: text: ....
object 2: name: 'c_prob_sym'
object 2: size: 4
object 2: data: b'\x11\x02\x00\x00'
object 2: hex : 0x11020000
object 2: int : 529
object 2: uint: 529
object 2: text: ....
object 3: name: 'd_prob_sym'
object 3: size: 4
object 3: data: b'\xef\x01\x00\x00'
object 3: hex : 0xef010000
object 3: int : 495
object 3: uint: 495
object 3: text: ....
Paths Processed : 5
```

## Replay for Example-2

```bash
KLEE: output directory is "/home/mlc6555/Documents/Research/PSE-Program-Examples/klee-out-0"
KLEE: Using Z3 solver backend

KLEE: done: total instructions = 134
KLEE: done: completed paths = 4
KLEE: done: generated tests = 4
ktest file : 'klee-last/test000001.ktest'
args       : ['example2.bc', '--set-ptree-dump']
num objects: 3
object 0: name: 'a_sym'
object 0: size: 4
object 0: data: b'\x00\x00\x00\x00'
object 0: hex : 0x00000000
object 0: int : 0
object 0: uint: 0
object 0: text: ....
object 1: name: 'b_sym'
object 1: size: 4
object 1: data: b'r\x04\x00\x00'
object 1: hex : 0x72040000
object 1: int : 1138
object 1: uint: 1138
object 1: text: r...
object 2: name: 'c_sym'
object 2: size: 4
object 2: data: b'r\x04\x00\x00'
object 2: hex : 0x72040000
object 2: int : 1138
object 2: uint: 1138
object 2: text: r...
Paths Processed : 4
```

## Replay for MontyHall 

```bash
KLEE: output directory is "/home/mlc6555/Documents/Research/PSE-Program-Examples/klee-out-0"
KLEE: Using Z3 solver backend
KLEE: WARNING: undefined reference to function: _ZSt17__throw_bad_allocv
KLEE: WARNING: undefined reference to function: _ZSt20__throw_length_errorPKc
KLEE: WARNING: undefined reference to function: _ZSt9terminatev
KLEE: WARNING: undefined reference to function: __cxa_begin_catch
KLEE: WARNING: undefined reference to function: __gxx_personality_v0
KLEE: WARNING ONCE: Alignment of memory from call "_Znwm" is not modelled. Using alignment of 8.

KLEE: done: total instructions = 3389
KLEE: done: completed paths = 14
KLEE: done: generated tests = 14
ktest file : 'klee-last/test000001.ktest'
args       : ['montyhall.bc', '--set-ptree-dump']
num objects: 4
object 0: name: 'door_switch_pse_var_sym'
object 0: size: 4
object 0: data: b'\x00\x00\x00\x00'
object 0: hex : 0x00000000
object 0: int : 0
object 0: uint: 0
object 0: text: ....
object 1: name: 'choice_pse_var_sym'
object 1: size: 4
object 1: data: b'\x02\x00\x00\x00'
object 1: hex : 0x02000000
object 1: int : 2
object 1: uint: 2
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
Paths Processed : 14
```


