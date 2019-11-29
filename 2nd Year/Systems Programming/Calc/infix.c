#include "infix.h"
//return true if op2 is higher precedence
bool is_higher_precedence(char op1, char op2){
    switch(op2){
        case '+': 
        return false;
        case '-': 
        return false;
        case 'X': 
        if (op1 == '+' || op1 == '-'){
            return true;
        }
        else return false;
        case '/': 
         if (op1 == '+' || op1 == '-'){
            return true;
        }
        else return false;
        case '^': 
        if (op1 != '^'){
            return true;
        }
        else return false;
        default: 
        return false;
    }
}


// evaluate expression stored as an array of string tokens
double evaluate_infix_expression(char ** args, int nargs) {
    char * plus = '+';
    char * mul = 'X';
    char * minus = '-';
    char * divide = '/';
    char * exponent = '^';
    int outputTerms = nargs;
    struct double_stack * temp = double_stack_new(nargs); //temporary stack for oporators
    char ** str = malloc(sizeof(char**) * nargs * 20);
    int strIndex = 0;
    for (int i = 0; i < nargs; i++){
        
        
        if(args[i][0] >= '0' && args[i][0] <= '9' || (args[i][0] == '-' && (args[i][1] >= '0' && args[i][1] <= '9'))){ 
            str[strIndex++] = args[i];
            printf("%s%c%s%d\n", "pointer array ", str[strIndex-1][0], " top: ", strIndex-1);
            
        }
        
        else if(args[i][0] == '(' &&  strlen(args[i]) == 1){
            double_stack_push(temp, args[i][0]); //is left bracket
            outputTerms -= 2; // as backslash takes up space
        }
        
        else if((strlen(args[i]) == 1) && //if operand
            (args[i][0] == '+' || args[i][0] == '-' || args[i][0] == 'X' || 
             args[i][0] == '/' || args[i][0] == '^' )){
                 
                while(is_higher_precedence(args[i][0], temp->items[(temp->top) - 1])){
                    char val = char_stack_pop(temp);
                        switch(val){
                             case '+':
                            printf("in plus\n");
                            str[strIndex++] = &plus;
                            break;
                            case '-':
                            printf("in minus\n");
                            str[strIndex++] = &minus;
                            break;
                            case 'X':
                            printf("in mul\n");
                            str[strIndex++] = &mul;
                            break;
                            case '/':
                            printf("in divide\n");
                            str[strIndex++] = &divide;
                            break;
                            case '^':
                            printf("in exp\n");
                            str[strIndex++] = &exponent;
                            break;
                         }
                 }
             char_stack_push(temp, args[i][0]);
        }
        
        else if(args[i][0] == ')' &&  strlen(args[i]) == 1){ //if left bracket
            while(temp->items[(temp->top) - 1] != '('){
                char val = char_stack_pop(temp);
                
            switch(val){
                case '+':
                printf("in plus\n");
                str[strIndex++] = &plus;
                break;
                case '-':
                printf("in minus\n");
                str[strIndex++] = &minus;
                break;
                case 'X':
                printf("in mul\n");
                str[strIndex++] = &mul;
                break;
                case '/':
                printf("in divide\n");
                str[strIndex++] = &divide;
                break;
                case '^':
                printf("in exp\n");
                str[strIndex++] = &exponent;
                break;
            }
            }
            if(temp->items[(temp->top) - 1] == '('){
                printf("popping left brak\n");
            char x = char_stack_pop(temp);
            }
        }
    }
    
        while(temp->top != 0){
            char val = char_stack_pop(temp);
            
            switch(val){
                case '+':
                printf("in plus\n");
                str[strIndex++] = &plus;
                break;
                case '-':
                printf("in minus\n");
                str[strIndex++] = &minus;
                break;
                case 'X':
                printf("in mul\n");
                str[strIndex++] = &mul;
                break;
                case '/':
                printf("in divide\n");
                str[strIndex++] = &divide;
                break;
                case '^':
                printf("in exp\n");
                str[strIndex++] = &exponent;
                break;
            }
         }
         printf("%d\n", outputTerms);
         for (int i = 0; i < outputTerms; i++){
           for (int j = 0; j < strlen(str[i]); j++){
              printf("%s%c%s%d%s%d\n", "this is output (end): ", str[i][j], "  length:", strlen(str[i]), " index: ", i);
            }
         }
         printf("about to eval\n");
        return evaluate_postfix_expression(str, outputTerms);
}


