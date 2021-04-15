add r0, #4, r9  ; int_inp = 4


max:                        ; int max(int a, int b, int c)
    add r0, r26, r1         ; r1 = v = a
    sub r27, r1, r0, {C}    ; if(b > v) then v = b
    jle max_1            ;
    xor r0, r0, r0          ; no operation
    add r0, r27, r1         ; 

max_1:
    sub r28, r1, r0, {C}    ; if(c > v) then v = c
    jle max_2               ;
    xor r0, r0, r0          ;
    add r0, r28, r1         ; 

max_2:
    ret r31, 0
    xor r0, r0, r0          ; no operation




max5:                          ; int p(int i, int j, int k, int l)
    add r0, r9, r10         ; r10 = r9 = int_inp = param 1
    add r0, r26, r11        ; r11 = i = param 2
    callr r31, max          ; r1 = max(r10, r11, r12) / max(int_inp, i, j)
    add r0, r27, r12        ; r12 = j = param 3

    add r0, r1, r10         ; r10 = max(int_inp, i, j) = param 1
    add r0, r28, r11        ; r11 = k = param 2
    callr r31, max          ; r1 = max((int_inp, i, j), k, l)
    add r0, r29, r12        ; r12 = l = param 3

    ret r31, 0
    xor r0, r0, r0          ; no operation





fun:                        ; int fun(int a, int b)
    sub r27, r0, r0, {C}    ; if(b == 0) then return 0
    jeq fun_3
    add r0, r0, r1           ; r1 = 0 

fun_1:
    add r0, r27, r10        ; r10 = b = param 1
    callr r31, mod          ; r1 = mod(b, 2)
    add r0, #2, r11         ; r11 = 2 = param 2
    sub r1, r0, r0, {C}     ; if(b % 2 == 0) then return fun(a + a, b / 2)
    jne fun_2
    add r0, r27, r10        ; r10 = b = param 1 (executed if jumped to fun_2 or not)
    callr r31, divide       ; r1 = divide(b, 2)
    add r0, #2, r11         ; r11 = 2 = param 2
    add r26, r26, r10       ; r10 = a + a = param 1
    callr r31, fun          ; r1 = fun(a + a, b / 2)
    add r0, r1, r11         ; r11 = b / 2 = param 2
    ret r31, 0
    xor r0, r0, r0          ; no operation

fun_2:    
    add r0, #2, r11         ; r11 = 2 = param 2
    callr r31, divide       ; r1 = divide(b, 2)
    add r26, r26, r10       ; r10 = a + a = param 1
    callr r31, fun          ; r1 = fun(a + a, b / 2)
    add r0, r1, r11         ; r11 = b / 2 = param 2
    add r1, r26, r1         ; r1 = fun(a + a, b / 2) + a

fun_3:
    ret r31, 0
    xor r0, r0, r0          ; no operation
