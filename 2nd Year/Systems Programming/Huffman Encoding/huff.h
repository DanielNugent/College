// header file for Huffman coder

#ifndef HUFF_H
#define HUFF_H
#define NUM_CHARS 256

struct huffchar {
  int freq;
  int is_compound;
  int seqno;
  int is_valid;
  union {
    struct {
      struct huffchar * left;
      struct huffchar * right;
    } compound;
    unsigned char c;
  } u;
};

struct huffcoder {
  int freqs[NUM_CHARS];
  int code_lengths[NUM_CHARS];
  unsigned long long codes[NUM_CHARS];
  struct huffchar * tree;
};
// create a new huffcoder structure



struct huffchar * huffchar_new(char ch, int f);

struct huffchar * compound_new(struct huffchar * a, struct huffchar * b, int seqno);

struct huffcoder *huffcoder_new();

int findSmallest(struct huffchar ** list, int nterms);

void huffcoder_count(struct huffcoder * this, char * filename);

void huffcoder_build_tree(struct huffcoder *this);

void go_node(struct huffchar * this, struct huffcoder * coder, long long code, int direction, int len);

// print the Huffman codes for each character in order
void huffcoder_tree2table(struct huffcoder * this);

void huffcoder_print_codes(struct huffcoder * this);

// encode the input file and write the encoding to the output file
void huffcoder_encode(struct huffcoder *this, char *input_filename,
                      char *output_filename);

// decode the input file and write the decoding to the output file
void huffcoder_decode(struct huffcoder * coder, char * input_filename,
		      char * output_filename);

#endif // HUFF_H
