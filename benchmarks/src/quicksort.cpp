#include <cstdio>
#include <iostream>
#include <random>
#define N 5

using namespace std;

// FILE* fp;

void swap(unsigned char *a, unsigned char *b) {
  unsigned char t = *a;
  *a = *b;
  *b = t;
}

int partition(unsigned char arr[], int p, int r, size_t *num_comps) {
  unsigned char pivot = arr[r];
  int i = (p - 1);

  for (int j = p; j <= r - 1; j++) {
    if (arr[j] <= pivot) {
      i++;
      swap(&arr[i], &arr[j]);
    }
    *num_comps += 1;
  }
  swap(&arr[i + 1], &arr[r]);
  return i + 1;
}

int randomized_partition(unsigned char arr[], int p, int r, size_t *num_comps) {
  // printf("%s\n", name.c_str());
  // uniform_int_sample(&i, sizeof(i), name.c_str(), (int) p, (int) r, fp);
  // make_pse_symbolic(&i, sizeof(i), name.c_str(), (int)p, (int)r);

  // PSE Symbolic Variable.
  std::default_random_engine generator;
  std::uniform_int_distribution<int> pivotIndex(p, r - 1);
  int i = pivotIndex(generator);

  // auto name = "i" + to_string(p) + to_string(r);
  // Choose between p and r.

  swap(&arr[i], &arr[r]);
  return partition(arr, p, r, num_comps);
}

void quicksort(unsigned char arr[], int p, int r, size_t *num_comps) {
  if (p < r) {
    *num_comps += 1;
    int q = randomized_partition(arr, p, r, num_comps);
    quicksort(arr, p, q - 1, num_comps);
    quicksort(arr, q + 1, r, num_comps);
  }
}

int main() {

  int FORALLS = 2;
  while (FORALLS--) {
    //  fp = fopen("test_dists.txt", "w+");
    int termCount = 2, win = 0, loop_count = 0;

    unsigned char arr[N];
    // klee_make_symbolic(&arr, sizeof(arr), "arr");
    std::default_random_engine generator;
    std::uniform_int_distribution<int> char_dist(0, 255);

    for (auto i = 0; i < N; i++)
      arr[i] = char_dist(generator);

    for (auto i = 0; i < N; i++)
      std::cout << arr[i] << ",";
    std::cout << "\n";

    while (termCount--) {

      unsigned char toSort[N];

      for (auto i = 0; i < N; i++)
        toSort[i] = arr[i];

      size_t num_comps = 0;
      // klee_make_symbolic(&num_comps, sizeof(num_comps), "num_comps");

      quicksort(toSort, 0, N - 1, &num_comps);

      // klee_dump_kquery_state();
      // klee_dump_symbolic_details(&num_comps, "num_comps");
      std::cout << "num_comps : " << num_comps << ", Iter : " << termCount
                << "\n";
      ///  fclose(fp);
      loop_count++;
    }
  }

  // auto pwin = (double)win / loop_count;
  // std::cout << "Prob Assert : " << pwin << "\n";
  return 0;
}