#include <assert.h>
#include <iostream>
#include <random>

// #define SIZE 4
int SIZE = 8;

int partition(int arr[], int left, int right) {
  srand(time(NULL));

  int random, pivot, outcome, left_count = 0, right_count = 0;

  // pivot element
  random = left + rand() % abs(right - left);
  pivot = arr[random];

  for (int j = left; j < right; j++) {
    arr[j] < pivot ? left_count++ : right_count++;
  }

  outcome = left_count < (right_count - 1) ? (right_count - 1) : left_count;
  return outcome;
}

int concrete[] = {2, 28, 95, 96, 47, 454, 65, -56, 7765, 234};

int main() {
  int arr[SIZE];
  for (auto i = 0; i < SIZE; i++)
    arr[i] = concrete[i];
  auto outcome = partition(arr, 0, SIZE - 1);
  std::cout << outcome << std::endl;
  return 0;
}
