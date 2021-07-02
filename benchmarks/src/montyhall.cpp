#include <assert.h>
#include <cstdio>
#include <iostream>
#include <random>
#include <time.h>
#include <vector>

int montyhall(int choice, int door_switch) {
  // PSE Symbolic Variable.
  std::default_random_engine generator;
  std::uniform_int_distribution<int> value_dist(1, 3);
  int car_door = value_dist(generator);
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
  int termCount = 0, win = 0, loop_count = 0;
  scanf("%d", &termCount);

  while (termCount--) {
    int choice;
    int door_switch;

    srand(time(0));
    std::default_random_engine generator;
    std::uniform_int_distribution<int> value_dist(1, 3);

    // Forall
    choice = value_dist(generator);
    // klee_make_symbolic(&choice, sizeof(choice), "choice_sym");
    // klee_assume(1 <= choice);
    // klee_assume(choice <= 3);

    // Forall
    door_switch = rand() > 1500 ? 0 : 1;
    // klee_make_symbolic(&door_switch, sizeof(door_switch), "door_switch_sym");
    // klee_assume(0 <= door_switch);
    // klee_assume(door_switch <= 1);

    auto ret = montyhall(choice, door_switch);
    if (ret) {
      // klee_dump_kquery_state();
      win++;
    }
    loop_count++;
  }

  auto pwin = (double)win / loop_count;
  std::cout << "Prob Assert : " << pwin << "\n";
  return 0;
}