#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <ctype.h>
#include <stdint.h>
#include "huff.h"
#include "bitfile.h"
// create a new huffcoder structure
struct huffchar * huffchar_new(char ch, int f){
    struct huffchar * this = malloc(sizeof(struct huffchar));
    this->freq = f;
    this->u.c = ch;
    this->is_valid = 1;
    this->is_compound = 0;
    this->seqno = (unsigned char)ch;
    return this;
}
struct huffchar * compound_new(struct huffchar * a, struct huffchar * b, int seqno){
    struct huffchar * this = malloc(sizeof(struct huffchar));
    this->freq = a->freq + b->freq;
    this->seqno= seqno;
    this->is_compound = 1;
    this->is_valid=1;
    this->u.compound.left = a;
    this->u.compound.right = b;
    return this;
}
struct huffcoder *huffcoder_new(){
    struct huffcoder * alphabet = malloc(sizeof(struct huffcoder));
    alphabet->tree = malloc(sizeof(struct huffchar));
    return alphabet;
}
// count the frequency of characters in a file; set chars with zero
// frequency to one
int findSmallest(struct huffchar ** list, int nterms){
    int k = 0;
    int seqnoL = list[k]->seqno;
    int smallest = 0;
    int minFreq = list[0]->freq;
    while(list[k]->is_valid != 1){
        minFreq = list[++k]->freq;
        smallest = k;
        seqnoL = list[k]->seqno;
    }
    for (int i = 1; i < nterms; i++){
        if(list[i]->is_valid == 1) { //if exists in list
            if (list[i]->freq < minFreq || (list[i]->seqno < seqnoL && list[i]->freq <= minFreq)) {
                smallest = i;
                minFreq = list[i]->freq;
                seqnoL = list[i]->seqno;
            }
        }
    }
    return smallest;
}
void huffcoder_count(struct huffcoder * this, char * filename)
{
    for(int i = 0; i < NUM_CHARS; i++){
        this->freqs[i] = 0;
    }
    FILE * f = fopen(filename, "r");
    char c;
    while ((c = fgetc(f)) != EOF){
        this->freqs[(int)c]++;
    }
    //setting all 0 values to 1
    for(int i = 0; i < NUM_CHARS; i++){
        if(this->freqs[i] == 0){
            this->freqs[i] = 1;
        }
    }
    fclose(f);
}
// using the character frequencies build the tree of compound
// and simple characters that are used to compute the Huffman codes
void huffcoder_build_tree(struct huffcoder *this)
{
    int terms = NUM_CHARS;
    int nchars = NUM_CHARS;
    struct huffchar ** alphabet;
    alphabet = malloc(sizeof(struct huffchar) * nchars);
    for (int i = 0; i < nchars; i++){
        alphabet[i] = huffchar_new(i, this->freqs[i]);
    }
    while(nchars > 1){
        int p1 = findSmallest(alphabet, nchars);
        struct huffchar * sml1 = alphabet[p1];
        sml1->is_valid = 0; //remove from list
        int p2 = findSmallest(alphabet, nchars);
        struct huffchar * sml2 = alphabet[p2];
        struct huffchar * compound = compound_new(sml1, sml2, terms);
        sml2->is_valid= 0;  //remove from list
        terms++;
        alphabet[p1] = compound;
        alphabet[p2] = alphabet[nchars-1];
        nchars--;
    }
    this->tree = alphabet[0]; //set root node
}
void go_node(struct huffchar * this, struct huffcoder * coder, long long code, int direction, int len){
    code += direction;
    code <<= 1;
    len++;
    if(this->is_compound != 0) {
        go_node(this->u.compound.left, coder, code, 0, len);
        go_node(this->u.compound.right, coder, code, 1, len);
    }
    else{
        code >>= 1;
        coder->codes[this->u.c] = code;
        coder->code_lengths[this->u.c] = len;
    }
}
// using the Huffman tree, build a table of the Huffman codes
// with the huffcoder object
void huffcoder_tree2table(struct huffcoder * this)
{
    long long code = 0;
    if(this->tree->is_compound != 0) {
        go_node(this->tree->u.compound.left, this, code, 0, 0);
        go_node(this->tree->u.compound.right, this, code, 1, 0);
    }
    else return;
}
void huffcoder_print_codes(struct huffcoder * this)
{
    int i, j;
    char buffer[NUM_CHARS];
    for ( i = 0; i < NUM_CHARS; i++ ) {
        // put the code into a string
        assert(this->code_lengths[i] < NUM_CHARS);
        int k = 0;
        for ( j = this->code_lengths[i]-1; j >= 0; j--) {
            buffer[k++] = ((this->codes[i] >> j) & 1) + '0';
        }
        buffer[this->code_lengths[i]] = '\0';
        printf("char: %d, freq: %d, code: %s\n", i, this->freqs[i], buffer);;
    }
}
// encode the input file and write the encoding to the output file
void huffcoder_encode(struct huffcoder *this, char *input_filename,
                      char *output_filename)
{
    FILE * input = fopen(input_filename, "r");
    struct bitfile * my_file = bitfile_open(output_filename, "w");
    unsigned char c;
    c = fgetc(input);
    while (!feof(input))
    {
        unsigned long long code = this->codes[c];
        int len = this->code_lengths[c];
        for (int i = len - 1; i >= 0; i--)
        {
            bitfile_write_bit(my_file, (code >> i) & 1);
        }
        c = fgetc(input);
    }
    int length = this->code_lengths[4];
    unsigned long long code = this->codes[4];
    for(int i = length-1; i >= 0; i--){
        bitfile_write_bit(my_file, (code >> i) & 1);
    }
    if(my_file->index != 0){
        fputc(my_file->buffer, my_file->file);
    }
    fclose(input);
    fclose(my_file->file);
}

// decode the input file and write the decoding to the output file
void huffcoder_decode(struct huffcoder * coder, char *input_filename,
                      char *output_filename)
{
    FILE *file;
    file = fopen(input_filename, "r");
    if (file == NULL) {
        printf("FATAL: error %s. Aborting program.\n", input_filename);
        exit(1);
    }
    struct bitfile *bitfile = bitfile_open(output_filename, "w");
    struct huffchar * leaf = coder->tree;
    int inFile = 1;
    unsigned char ch;
    while (inFile == 1) {
        ch = (unsigned char)fgetc(file);
        if ((char)ch == EOF){
           inFile = 0;
        }
        for (int i = 0; i < 8; i++) {
            int dir = (ch >> i) & 1;
            if (leaf->is_compound== 1) {
                if (dir == 1) leaf = leaf->u.compound.right;
                else leaf = leaf->u.compound.left;
            } else {
                if (leaf->u.c != 4) {
                    fputc(leaf->u.c, bitfile->file);
                    leaf = coder->tree;
                    if (dir == 1) {
                        leaf = leaf->u.compound.right;
                   } else {
                        leaf = leaf->u.compound.left;
                    }
                } else {
                    inFile = 0;
                }
            }
        }
    }
    fclose(bitfile->file);
    fclose(file);
}

