#include <algorithm>
#include <assert.h>
#include <fstream>
#include <functional>
#include <getopt.h> /* getopt */
#include <iomanip>
#include <iostream>
#include <iterator>
#include <json.hpp>
#include <random>
#include <set>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>
unsigned int microseconds = 10000000;

#define CLASSES 2
#define FORALLS 3
#define RUNS 1000
#define BUCKET_SIZE 2
#define SIZE 6

/**
 * switch => door_switch
 */
bool montyhall(bool door_switch, int choice) {

  int host_door = 0;
  int car_door = rand() % 4;

  //   make_pse_symbolic(&choice, sizeof(choice), "choice_pse_sym", 0, 3);
  //   make_pse_symbolic(&car_door, sizeof(car_door), "car_door_pse_sym", 0, 3);
  //   klee_make_symbolic(&host_door, sizeof(host_door), "host_door_sym");

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

  srand(time(NULL));
  std::vector<std::vector<int>> counters(CLASSES,
                                         std::vector<int>(BUCKET_SIZE, 0));

  int forall_classes = CLASSES;
  int door_switch;
  while (forall_classes--) {

    if (forall_classes == 1)
      door_switch = 1;

    if (forall_classes == 0)
      door_switch = 0;

    int forall_samples = FORALLS;
    while (forall_samples--) {

      int choice = forall_samples;
      int runs = RUNS;
      while (runs--) {
        bool ret = montyhall(door_switch, choice);

        if (ret == 1) {
          counters[forall_classes][0] += 1;
        }
        if (ret == 0) {
          counters[forall_classes][1] += 1;
        }
        printf("Class : %d, Forall : %d, Runs : %d, MontyHall : %d\n",
               forall_classes, forall_samples, runs, ret);
      }
    }
  }
  for (const auto &x : counters) {
    std::cout << std::endl;
    for (const auto &e : x) {
      std::cout << std::setw(7) << e << ",";
    }
  }
  std::cout << std::endl;

  int classCounter = 0;
  int flag = 0;
  for (const auto &x : counters) {
    classCounter++;
    std::cout << std::endl;
    int bucketCounter = 0;
    if (flag == 0)
      for (const auto &e : x)
        std::cout << std::setw(5) << "B" << bucketCounter++;
    flag = 1;
    std::cout << "\n"
              << "C" << classCounter;
    for (const auto &e : x) {
      e >= 17000 ? std::cout << std::setw(5) << 1 << ","
                 : std::cout << std::setw(5) << 0 << ",";
    }
  }
  std::cout << std::endl;
  return 0;
}