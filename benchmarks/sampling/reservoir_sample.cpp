#include <algorithm>
#include <assert.h>
#include <fstream>
#include <functional>
#include <getopt.h> /* getopt */
#include <iomanip>
#include <iostream>
#include <random>
#include <set>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unordered_map>
#include <unordered_set>
#include <utility>
#include <vector>

#ifndef MIN_RANGE
#define MIN_RANGE -2147483646
#endif

#ifndef MAX_RANGE
#define MAX_RANGE 2147483646
#endif

std::random_device rd;
std::default_random_engine seed(rd());
std::uniform_int_distribution<int> random_engine_block2(0, MAX_RANGE);
auto pos_sampler = std::bind(random_engine_block2, seed);

std::uniform_int_distribution<int> random_engine_block1(MIN_RANGE, MAX_RANGE);
auto all_sampler = std::bind(random_engine_block1, seed);

int main(int argc, char **argv, char **envp) {

  std::vector<std::pair<int, int>> setCounts;

  int forall_samples = 10, FORALLS = 0;
  int RUNMAIN = 50, n = 10, n_given = 0, k = 5, k_given = 0,
      pick_random_test = 0, print_md = 0;
  int opt = 0;

  while ((opt = getopt(argc, argv, ":f:r:n:k:p:l:")) != -1) {
    switch (opt) {
    case 'f':
      forall_samples = atoi(optarg);
      FORALLS = forall_samples;
      printf("Forall Samples: %d\n", forall_samples);
      break;
    case 'r':
      RUNMAIN = atoi(optarg);
      printf("Run for each sample: %d\n", RUNMAIN);
      break;
    case 'n':
      n = atoi(optarg);
      n_given = 1;
      printf("Total Size (n) Supplied: %d\n", n);
      break;
    case 'k':
      k = atoi(optarg);
      k_given = 1;
      printf("Reservoir Size (k) Supplied: %d\n", k);
      break;
    case 'p':
      pick_random_test = atoi(optarg);
      std::cerr << "```\n Random Pick \n```\n";
      printf("Pick Random: %d\n", pick_random_test);
      break;
    case 'l':
      print_md = atoi(optarg);
      printf("Print Latex/MKD: %d\n", print_md);
      break;
    case '?':
      printf("Unknown option: %c\n", optopt);
      exit(-1);
      break;
    case ':':
      printf("Missing arg for %c\n", optopt);
      break;
    }
  }

  std::fstream fs;
  float pt = 0.00000f, pr = 0.00000f;
  std::set<std::vector<int>> probSamples;

  print_md ? std::cerr << "| Forall"
                       << " | set1(count==1) | set2(count==0) |\n | :---: | "
                          ":---: | :---: |\n"
           : std::cerr << " Forall"
                       << " & set1(count==1) & set2(count==0) \\\\ \\hline \n";

  while (forall_samples--) {
    srand(time(NULL));

    std::string filename =
        std::string("tests/test_") + std::to_string(forall_samples);
    fs.open(filename.c_str(), std::fstream::out);
    fs << "\n=== ForAll Sample : " << forall_samples << " ===\n";
    std::cout << "\n*** ForAll Sample : " << forall_samples << " ***\n";

    if (!n_given)
      n = 5 + rand() % 32413;
    if (!k_given)
      k = 5 + rand() % 32413;

    int index1 = pick_random_test ? rand() % (n - 1) : 2;

    // This is the index of the element we want to check for.
    // Over all the runs, the expected hit-count for this element
    // should be (n / k) for "perfect" reservoir sampling, given
    // we do a large number of runs.
    fs << "\n\tForall Variable : index_picked1 \n\t\t" << index1 << "\n";
    int count = 0, runs = RUNMAIN;

    // Sample must be smaller or equal
    // to input size. Can't be greater.
    while (k >= n) {
      k = 2 + rand() % 32413;
    }

    pr = (float)(double(k) / n);
    std::cout << "\n(reservoir) k : " << k << "\n(input size) n : " << n
              << "\nexpected prob : " << pr << " (k/n)\n";

    // Input array.
    int arr[n];
    memset(arr, 0, sizeof(int) * n);

    // This is the sampling reservoir.
    int sample[k];
    memset(sample, 0, sizeof(int) * k);

    fs << "\n\tForall Variable : n \n";
    fs << "\t\t" << n << "\n";
    fs << "\n\tForall Variable : k \n";
    fs << "\t\t" << k << "\n";
    fs << "\n\tForall Array : arr[n] \n";

    // We populated the input list from which we
    // want to sample values and fill the reservoir.
    for (auto elems = 0; elems < n; elems++) {
      arr[elems] =
          rand() % 61283 + (307 * (rand() % 4423) - 257 * (rand() % 1571));
      fs << "\t\t" << arr[elems] << "\n";
    }

    // Fill the reservoir completely.
    for (int i = 0; i < k; i++) {
      sample[i] = arr[i];
    }

    // "j" values vector.
    std::vector<int> j_samples;

    while (runs--) {
      j_samples.clear();

      fs << "\n=== Run : " << runs << " ===\n";

      fs << "\n\tPSE Variable : j \n";
      for (int i = k; i < n; i++) {
        // j is the PSE variable here.
        int j = rand() % i;
        fs << "\t\t" << j << "\n";
        j_samples.push_back(j);

        // Replace the element with [k / (k + i)] prob.
        if (j <= k) {
          // Pick an element at random
          // and replace it with elem.
          int pick = rand() % (k - 1);
          sample[pick] = arr[i];
        }
      }

      int ret = 0;
      for (int i = 0; i < k; i++) {
        // See if we have the element we are
        // looking for in the sample.
        if (arr[index1] == sample[i]) {
          // Increment the count since we have seen the element.
          count++;
          break;
        }
      }

      // std::cout << "\n\t\tRun : " << runs << ", Count : " << count;
    }

    probSamples.insert(j_samples);

    pt = (float)((double)count / RUNMAIN);
    std::cout << "\n\033[1;33m=== COUNT : " << count << " ===\033[0m\n";

    print_md
        ? std::cerr << "| Setting" << std::setw(4) << FORALLS - forall_samples
                    << " | " << std::setw(4) << count << " | " << std::setw(4)
                    << RUNMAIN - count << "|\n"
        : std::cerr << " Setting " << std::setw(4) << FORALLS - forall_samples
                    << " & " << std::setw(4) << count << "  (" << pt << ")"
                    << " & " << std::setw(4) << RUNMAIN - count << "  ("
                    << std::setw(4) << (float)(1.0000 - pt) << ")"
                    << " \\\\ \\hline \n";

    setCounts.emplace_back(std::make_pair(count, RUNMAIN - count));

    fs << "\n\n=== Mass Collected : " << (float)(((float)pt / pr) * 100)
       << "% ===\nActual Prob : " << pt << ", Expected Prob : " << pr << "\n";

    std::cout << "=== Mass Collected : " << (float)(((float)pt / pr) * 100)
              << "% ===\nActual Prob : " << pt << ", Expected Prob : " << pr
              << "\n";
    if (pt >= pr) {
      fs << "\nThreshold Reached !\n";
      std::cout << "Threshold Reached !\n";
    }

    fs.close();
  }

  std::cerr << std::endl << "```javascript\n";
  for (const auto &elem : setCounts) {
    std::cerr << std::setw(10) << "Setting : " << std::setw(5) << elem.first
              << ", " << std::setw(5) << elem.second << "\n";
  }
  std::cerr << std::endl << "```";

  return 0;
}