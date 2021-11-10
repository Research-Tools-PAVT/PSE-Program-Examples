import subprocess
import json
import sys
import os


name = sys.argv[1]

with open(f"{name}_processed/{name}_paths.json", 'r+', encoding='utf-8') as f:
    paths = json.load(f)
    subprocess.call(f"g++ ./{name}.cpp -I /home/klee/klee_build/include/ -L /home/klee/klee_build/lib/ -lkleeRuntest", shell=True)

    for path, conjuncts in paths.items():
        pathNum = ''.join(filter(str.isdigit, path)).zfill(6)
        
        retcode = subprocess.call(f"KTEST_FILE={name}_klee_out/test{pathNum}.ktest ./a.out", shell=True)

        newCon = {}
        newCon["treeNode"] = {"nodeId":"-1", "uid":"NA"}
        newCon["predicate"] = f"(Eq {retcode} (ReadLSB w32 0 retval))"
        newCon["variables"] = []
        newCon["IMap"] = {}
        newCon["nodeTrueQuery"] = []
        newCon["nodeFalseQuery"] = []
        
        conjuncts.append(newCon)
        paths[path] = conjuncts

    f.seek(0)
    json.dump(paths, f)
    f.truncate()
