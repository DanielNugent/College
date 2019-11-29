// C code file for  a file ADT where we can read a single bit at a
// time, or write a single bit at a time

#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include <stdio.h>

#include "bitfile.h"

// open a bit file in "r" (read) mode or "w" (write) mode
struct bitfile * bitfile_open(char * filename, char * mode)
{
    struct bitfile * this_file = malloc(sizeof(struct bitfile));
    this_file->index = 0;
    this_file->buffer = 0;
    this_file->file = fopen(filename, mode);
    if(strcmp(mode, "r") == 0){
        this_file->is_read_mode = 1;
    }
    else this_file->is_read_mode = 0;
    return this_file;
}

// write a bit to a file; the file must have been opened in write mode
void bitfile_write_bit(struct bitfile *this, int bit)
{
    this->buffer |= (bit << this->index);
    this->index++;

    if (this->index == 8)
    {
        fputc(this->buffer, this->file);
        this->index = 0;
        this->buffer = 0;
    }
}

// read a bit from a file; the file must have been opened in read mode
int bitfile_read_bit(struct bitfile * this)
{
    if(this->index == 0){
        if(feof(this->file)){
            return -1;
        }
        this->buffer = fgetc(this->file);
    }
    int k = (this->buffer & 1);
    this->buffer>>=1;
    this->index++;
    if(this->index == 8){
        this->index = 0;
    }
    return k;
}

// close a bitfile; flush any partially-filled buffer if file is open
// in write mode
void bitfile_close(struct bitfile * this) {
    if(!this->is_read_mode) {
        this->buffer = 0;
        this->index = 0;
        fclose(this->file);
    }
}

// check for end of file
int bitfile_end_of_file(struct bitfile * this)
{
    return (this->is_EOF == 1);
}
