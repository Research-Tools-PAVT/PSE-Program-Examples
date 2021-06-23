#include <cstdio>
#include <iostream>

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
  int i;
  auto name = "i" + to_string(p) + to_string(r);
  printf("%s\n", name.c_str());
  //  uniform_int_sample(&i, sizeof(i), name.c_str(), (int) p, (int) r, fp);
  // make_pse_symbolic(&i, sizeof(i), name.c_str(), (int)p, (int)r);
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
  //  fp = fopen("test_dists.txt", "w+");

  unsigned char arr[N];
  // klee_make_symbolic(&arr, sizeof(arr), "arr");

  size_t num_comps;
  // klee_make_symbolic(&num_comps, sizeof(num_comps), "num_comps");
  num_comps = 0;

  quicksort(arr, 0, N - 1, &num_comps);

  // klee_dump_kquery_state();
  // klee_dump_symbolic_details(&num_comps, "num_comps");
  std::cout << "num_comps : " << num_comps << "\n";
  ///  fclose(fp);
  return 0;
}