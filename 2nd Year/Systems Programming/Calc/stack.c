#include "stack.h"

struct double_stack * double_stack_new(int max_size) {
  struct double_stack * result;
  result = malloc(sizeof(struct double_stack));
  result->max_size = max_size;
  result->top = 0;
  result->items = malloc(sizeof(double)*max_size);
  return result;
}

// push a double value onto the stack

void double_stack_push(struct double_stack * this, double value){
   this->items[this->top++] = value;
}

//pop double value off stack
double double_stack_pop(struct double_stack * this){
   return this->items[--this->top];
}
//push a char value on stack
void char_stack_push(struct double_stack * this, char value){
   this->items[this->top++] = value;
}
//pop a char value off stack
char char_stack_pop(struct double_stack * this){
   return this->items[--this->top];
}

