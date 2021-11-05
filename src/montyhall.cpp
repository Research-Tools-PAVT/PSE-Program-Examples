// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions
// -emit-llvm -c -o %t1.bc %s RUN: rm -rf %t.klee-out RUN: %klee
// --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests
// --exit-on-error --optimize --disable-inlining --search=nurs:depth
// --use-cex-cache %t1.bc

#include "PSE.h"
#include <assert.h>
#include <stdio.h>
#include <vector>

/**
 * switch => door_switch
 */
bool montyhall(bool door_switch, int choice) {

  int host_door = 0;
  int car_door;

  make_pse_symbolic(&car_door, sizeof(car_door), "car_door_pse_sym", 0, 3);
  klee_make_symbolic(&host_door, sizeof(host_door), "host_door_sym");

  /**
   * Based on car door and choice, choose a host door.
   */
  if (car_door != 1 && choice != 1) {
    host_door = 1;
  } else if (car_door != 2 && choice != 2) {
    host_door = 2;
  } else {
    host_door = 3;
  }

  /**
   * Based door_switch and host_door, change choices.
   */
  if (door_switch) {
    if (host_door == 1) {
      if (choice == 2) {
        choice = 3;
      } else {
        choice = 2;
      }
    } else if (host_door == 2) {
      if (choice == 1) {
        choice = 3;
      } else {
        choice = 1;
      }
    } else {
      if (choice == 1) {
        choice = 2;
      } else {
        choice = 1;
      }
    }
  }

  if (choice == car_door) {
    return true;
  } else {
    return false;
  }

  return true;
}

int main() {
  int door_switch = 0, choice;

  make_pse_symbolic(&door_switch, sizeof(door_switch), "door_switch_pse_sym", 0,
                    1);
  make_pse_symbolic(&choice, sizeof(choice), "choice_pse_sym", 0, 3);

  bool ret = montyhall(door_switch, choice);
  klee_print_expr("Ret : ", ret);

  /* COMMENT : KLEE ASSUMES from ANALYSIS */
  klee_assume((door_switch == 1 && ret == 0) ||
              (door_switch == 1 && ret == 1) ||
              (door_switch == 0 && choice != 1 && ret == 1));

  return 0;
}

/*
```

Without Assumes :
KLEE: done: total instructions = 527
KLEE: done: completed paths = 14
KLEE: done: partially completed paths = 0
KLEE: done: generated tests = 10

With Assumes :
KLEE: done: total instructions = 851
KLEE: done: completed paths = 7
KLEE: done: partially completed paths = 7
KLEE: done: generated tests = 14

With Assumes Refined :
KLEE: done: total instructions = 868
KLEE: done: completed paths = 4
KLEE: done: partially completed paths = 12
KLEE: done: generated tests = 16


-------------------------------------|
    |   B0 (ret==1)  |   B1 (ret==0) |
----|----------------|---------------|
C0  |      1         |       1       |  (door_switch==1)
C1  |      0         |       1       |  (door_switch==0)
----|----------------|---------------|
```
*/