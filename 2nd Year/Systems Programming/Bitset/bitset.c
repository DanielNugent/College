#include <stdio.h>

#include <stdlib.h>

#include <math.h>

#include <stdint.h>

#include "bitset.h"

// create a new, empty bit vector set with a universe of 'size' items
struct bitset * bitset_new(int size) {
  struct bitset * bitset = calloc(1, sizeof(bitset));
  bitset - > universe_size = size;
  bitset - > size_in_words = (size + 63 / 64);
  bitset - > bits = calloc(bitset - > size_in_words, sizeof(uint64_t));
  return bitset;
}

// get the size of the universe of items that could be stored in the set
int bitset_size(struct bitset * this) {
  return this - > universe_size;
}

// get the number of items that are stored in the set
int bitset_cardinality(struct bitset * this) {
  int c = 0;
  for (int i = 0; i < this - > size_in_words; i++) {
    uint64_t word = this - > bits[i];
    while (this - > bits != 0) {
      c += (word & 1);
      word >>= 1;
    }
  }
  return c;
}

// check to see if an item is in the set
int bitset_lookup(struct bitset * this, int item) {
  uint64_t word;
  word = this - > bits[(int) item / 64];
  if (item > 64)
    item %= 64;
  word >>= item;
  word = word & 1;
  if (word == 1)
    return 1;
  return 0;
}

// add an item, with number 'item' to the set
// has no effect if the item is already in the set
void bitset_add(struct bitset * this, int item) {
  uint64_t temp;
  uint64_t word;
  int temp_item = item;
  word = this - > bits[(int) item / 64];
  if (item > 64)
    temp_item %= 64;
  temp = word;
  word >>= temp_item;
  word = word & 1;
  if (word == 0) {
    word = 1;
    word <<= item;
    word = word | temp;
    this - > bits[(int) item / 64] = word;
  }
}

// remove an item with number 'item' from the set
void bitset_remove(struct bitset * this, int item) {
  uint64_t temp;
  uint64_t word;
  int temp_item = item;
  word = this - > bits[(int) item / 64];
  if (item > 64)
    temp_item %= 64;
  temp = word;
  word >>= temp_item;
  word = word & 1;
  if (word == 1) {
    word = 1;
    word <<= item;
    word = ~word;
    word = word & temp;
    this - > bits[(int) item / 64] = word;
  }
}

// place the union of src1 and src2 into dest;
// all of src1, src2, and dest must have the same size universe
void bitset_union(struct bitset * dest, struct bitset * src1, struct bitset * src2) {
  if (src1 - > universe_size == src2 - > universe_size && dest - > universe_size == src2 - > universe_size) {
    for (int i = 0; i < src1 - > size_in_words; i++) {
      dest - > bits[i] = src1 - > bits[i] | src2 - > bits[i];
    }
  }
}

// place the intersection of src1 and src2 into dest
// all of src1, src2, and dest must have the same size universe
void bitset_intersect(struct bitset * dest, struct bitset * src1, struct bitset * src2) {
  if (src1 - > universe_size == src2 - > universe_size && dest - > universe_size == src2 - > universe_size) {
    for (int i = 0; i < src1 - > size_in_words; i++) {
      dest - > bits[i] = src1 - > bits[i] & src2 - > bits[i];
    }
  }
}
