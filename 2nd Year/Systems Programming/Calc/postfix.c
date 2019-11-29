#include "postfix.h"

//applys operator operand to top two elements of stack and pushes result to top of stack
void apply_operator(struct double_stack * stack, char operand) {
    double value1 = double_stack_pop(stack);
    double value2 = double_stack_pop(stack);
    double result;
    switch(operand
    ) {
        case '+': result = value2 + value1;
          break;
        case '-': result = value2 - value1;
          break;
        case 'X': result = value2 * value1;
          break;
        case '/': result = value2 / value1;
          break;
        case '^': result = pow(value2, value1);
          break;
        default: result = 0;
        break;
  }

   double_stack_push(stack, result);

}
// evaluate expression stored as an array of string tokens
double evaluate_postfix_expression(char ** args, int nargs) {
  struct double_stack * stack = double_stack_new(nargs); 
  double value;

  for (int i = 0; i < nargs; i++){
    if (strlen(args[i]) == 1){ //one character?
      value = atof(args[i]); //get numerical value from characters
      switch(args[i][0]){
        case '+': apply_operator(stack, '+');
          break;
        case '-': apply_operator(stack, '-');
         break;
        case 'X': apply_operator(stack, 'X');
          break;
        case '/': apply_operator(stack, '/');
          break;
        case '^': apply_operator(stack, '^');
          break;
        default:
          if (i == nargs -1){ // if incorrectly formatted, return the result correctly
              return double_stack_pop(stack);
          }
          value = atof(args[i]); //if isn't operator
          double_stack_push(stack, value);
          break;     
      }
    }
    else {
          value = atof(args[i]); //if isn't operator
          double_stack_push(stack, value);
    }

  }
      value = double_stack_pop(stack);
      return value; 
}
