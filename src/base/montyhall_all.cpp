// RUN: %clangxx -I../../../include -g -DMAX_ELEMENTS=4 -fno-exceptions
// -emit-llvm -c -o %t1.bc %s RUN: rm -rf %t.klee-out RUN: %klee
// --output-dir=%t.klee-out --libc=klee --max-forks=25 --write-no-tests
// --exit-on-error --optimize --disable-inlining --search=nurs:depth
// --use-cex-cache %t1.bc

#include "PSE.h"
#include "klee/klee.h"
#include <assert.h>
#include <stdio.h>
#include <vector>

/**
 * switch => door_switch
 */
bool montyhall(bool door_switch, int choice) {

  int host_door = 0;
  int car_door;

  make_pse_symbolic(&car_door, sizeof(car_door), "car_door_pse", 0, 3);
  klee_make_symbolic(&host_door, sizeof(host_door), "host_door_sym");

  host_door = 0;
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
  int ret = 0;

  make_pse_symbolic(&door_switch, sizeof(door_switch), "door_pse", 0, 1);
  make_pse_symbolic(&choice, sizeof(choice), "choice_pse", 0, 3);

  ret = montyhall(door_switch, choice);

  if (ret == 1) {
    mark_state_winning();
  }

  expected_value("ret", ret);
  return 0;
}