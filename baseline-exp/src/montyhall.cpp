#include <assert.h>
#include <cstdio>
#include <iostream>
#include <vector>

int montyhall(int choice, int door_switch) {
  int car_door;
  // make_pse_symbolic(&car_door, sizeof(car_door), "car_door_sym", 1, 3);

  if (choice == car_door) {
    return door_switch != 1;
  } else {
    int host_door;
    if (choice != 1 && car_door != 1) {
      host_door = 1;
    } else if (choice != 2 && car_door != 2) {
      host_door = 2;
    } else {
      host_door = 3;
    }

    if (door_switch == 1) {
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
    return choice == car_door;
  }
}

int main() {
  int choice;
  int door_switch;

  // klee_make_symbolic(&choice, sizeof(choice), "choice_sym");
  // klee_assume(1 <= choice);
  // klee_assume(choice <= 3);
  // klee_make_symbolic(&door_switch, sizeof(door_switch), "door_switch_sym");
  // klee_assume(0 <= door_switch);
  // klee_assume(door_switch <= 1);

  auto ret = montyhall(choice, door_switch);
  if (ret) {
    // klee_dump_kquery_state();
    std::cout << "ret : " << ret << "\n";
  }

  return 0;
}