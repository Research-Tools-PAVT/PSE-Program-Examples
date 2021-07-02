#include <iostream>
#include <random>
#include <skiplist.h>
#include <stdio.h>
#include <stdlib.h>

#define N 3

void sl_free_entry(sl_entry *entry);

// TODO have void functions (especially sl_set) return error codes and do proper
//      checking after allocations.

// Returns a random number in the range [1, max] following the geometric
// distribution.
int grand(int max) {
  int result = 1;

  int rand;
  // make_pse_symbolic(&rand, sizeof(rand), "rand", 0, 1);
  while (result < max && rand) {
    // make_pse_symbolic(&rand, sizeof(rand), "rand", 0, 1);
    ++result;
  }

  return result;
}

// Returns a sentinel node representing the head node of a new skip list.
// Also seeds the random number generator the first time it is called.
sl_entry *sl_init() {
  /* // Seed the random number generator if we haven't yet */
  /* if (!seeded) { */
  /*     srand((unsigned int) time(NULL)); */
  /*     seeded = 1; */
  /* } */

  // Construct and return the head sentinel
  sl_entry *head =
      (sl_entry *)calloc(1, sizeof(sl_entry)); // Calloc will zero out next
  if (!head)
    return NULL; // Out-of-memory check
  head->height = MAX_SKIPLIST_HEIGHT;

  return head;
}

// Frees all nodes in the skiplist
void sl_destroy(sl_entry *head) {
  sl_entry *current_entry = head;
  sl_entry *next_entry = NULL;
  while (current_entry) {
    next_entry = current_entry->next[0];
    sl_free_entry(current_entry);
    current_entry = next_entry;
  }
}

// Searches for an entry by key in the skip list, and returns a copy of
// the associated value, or NULL if the key was not found.
int sl_get(sl_entry *head, int key, int *cost) {
  sl_entry *curr = head;
  int level = head->height - 1;

  // Find the position where the key is expected
  while (curr != NULL && level >= 0) {
    if (curr->next[level] == NULL) {
      --level;
    } else {
      *cost += 1;
      if (curr->next[level]->key == key) { // Found a match
        return curr->next[level]->value;
      } else if (curr->next[level]->key > key) { // Drop down a level
        --level;
      } else { // Keep going at this level
        curr = curr->next[level];
      }
    }
  }
  // Didn't find it
  return -1;
}

// Inserts copies of a key, value pair into the skip list,
// replacing the value associated with the key if it is already
// in the list.
void sl_set(sl_entry *head, int key, int value) {
  sl_entry *prev[MAX_SKIPLIST_HEIGHT];
  sl_entry *curr = head;
  int level = head->height - 1;

  // Find the position where the key is expected
  while (curr != NULL && level >= 0) {
    prev[level] = curr;
    if (curr->next[level] == NULL) {
      --level;
    } else {
      if (curr->next[level]->key ==
          key) { // Found a match, replace the old value
        curr->next[level]->value = value;
        return;
      } else if (curr->next[level]->key > key) { // Drop down a level
        --level;
      } else { // Keep going at this level
        curr = curr->next[level];
      }
    }
  }

  // Didn't find it, we need to insert a new entry
  sl_entry *new_entry = (sl_entry *)malloc(sizeof(sl_entry));
  new_entry->height = grand(head->height); // Need to change here!
  new_entry->key = key;
  new_entry->value = value;
  int i;
  // Null out pointers above height
  for (i = MAX_SKIPLIST_HEIGHT - 1; i > new_entry->height; --i) {
    new_entry->next[i] = NULL;
  }
  // Tie in other pointers
  for (i = new_entry->height - 1; i >= 0; --i) {
    new_entry->next[i] = prev[i]->next[i];
    prev[i]->next[i] = new_entry;
  }
}

// Frees the memory allocated for a skiplist entry.
void sl_free_entry(sl_entry *entry) {
  free(entry);
  entry = NULL;
}

// Removes a key, value association from the skip list.
void sl_unset(sl_entry *head, int key) {
  sl_entry *prev[MAX_SKIPLIST_HEIGHT];
  sl_entry *curr = head;
  int level = head->height - 1;

  // Find the list node just before the condemned node at every
  // level of the chain
  int cmp = 1;
  while (curr != NULL && level >= 0) {
    prev[level] = curr;
    if (curr->next[level] == NULL) {
      --level;
    } else {
      cmp = curr->next[level]->key >= key;
      if (cmp) { // Drop down a level
        --level;
      } else { // Keep going at this level
        curr = curr->next[level];
      }
    }
  }

  // We found the match we want, and it's in the next pointer
  if (curr && !cmp) {
    sl_entry *condemned = curr->next[0];
    // Remove the condemned node from the chain
    int i;
    for (i = condemned->height - 1; i >= 0; --i) {
      prev[i]->next[i] = condemned->next[i];
    }
    // Free it
    sl_free_entry(condemned);
    condemned = NULL;
  }
}

/**
 * @brief Try this example out.
 * Could add to paper.
 *
 * @return int
 */
int main() {
  int termCount = 0, win = 0, loop_count = 0;
  scanf("%d", &termCount);

  while (termCount--) {

    // Create a list
    std::default_random_engine generator;
    std::uniform_int_distribution<int> random_range(INT32_MIN, INT32_MAX);

    sl_entry *list = sl_init();

    int cost = 0;
    // klee_make_symbolic(&cost, sizeof(cost), "cost");

    int search_key = random_range(generator),
        search_val = random_range(generator);
    // klee_make_symbolic(&search_key, sizeof(search_key), "search_key");
    // klee_make_symbolic(&search_val, sizeof(search_val), "search_val");

    for (int i = 0; i < N - 1; i++) {
      int key = random_range(generator), val = random_range(generator);
      // klee_make_symbolic(&key, sizeof(key), "key");
      // klee_make_symbolic(&val, sizeof(val), "val");
      sl_set(list, key, val);
    }

    sl_set(list, search_key, search_val);

    // Perform a lookup
    sl_get(list, search_key, &cost);

    // Free the list and all its nodes
    sl_destroy(list);

    // klee_dump_kquery_state();
    // klee_dump_symbolic_details(&cost, "cost");

    // E[cost]
    if (cost > 0) {
      win++;
      std::cout << "cost : " << cost << "\n";
    }
    loop_count++;
  }

  auto pwin = (double)win / loop_count;
  std::cout << "Prob Assert : " << pwin << "\n";
  return 0;
}