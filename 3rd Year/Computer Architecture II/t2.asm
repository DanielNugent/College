includelib legacy_stdio_definitions.lib
extrn printf:near
extrn scanf:near


;; Data segment

.data

	use_scanf_string0 BYTE "Please enter an integer: ", 00h
	use_scanf_string1 BYTE "%lld", 00h
	use_scanf_string2 BYTE "The sum of proc. and user inputs (%lld, %lld, %lld, %lld): %lld", 0Ah, 00
	print_string BYTE "Sum of i: %I64d and j: %lld is: %I64d", 0Ah, 00h
	print_string2 BYTE "Sum of i: %I64d, j: %lld and bias: %lld is: %I64d", 0Ah, 00h
	bias QWORD 50
	sum2 QWORD 0
	inp_int QWORD 0

;; Code segment
.code
public inp_int
public fibX64;

;;rcx = ll fin
fibX64:
    cmp rcx, 0         
    jle fib_end				  ; if (fin <= 0) return fin.
	cmp rcx, 1 ;  
	je fib_one				  ; if fin = 1 return 1;
    ;preserve fin
	mov [rsp+8], rcx		  ; preserving fin in shadow space
	sub rsp, 32				  ; shadow space
	sub rcx, 1				  ;rcx - 1
	call fibX64               ; fibX64(fin-1)
	mov [rsp+48], rax         ; fibX64(fin-1)
	mov rcx, [rsp+40]         ; rcx = fin
	sub rcx, 2                ; rcx - 2
	call fibX64                
	mov rcx, rax
	add rcx, [rsp+48]
	add rsp, 32				  ; add shadow space back
	jmp fib_end
fib_one:                  
    mov rcx, 1			      ; The result would be 1
fib_end:
    mov rax, rcx
    ret



public use_scanf;
;rcx = ll a
;rdx = ll b
;r8  = ll c
use_scanf:
   xor rax, rax ; rax = 0
   lea rax, [rcx+rdx]      ; rax = a+b
   add rax, r8             ; rax = a+b+c
   mov [rsp+8], rcx        ; rsp+8 = a
   mov [rsp+16], rdx       ; rsp+16 = b
   mov [rsp+24], r8        ; rsp+24 = c
   mov [rsp+32], rax       ; rsp+32 = sum = a + b + c
   sub rsp, 56             ; allocate shadow space
   lea rcx, use_scanf_string0 
   call printf
   lea rcx, use_scanf_string1 
   mov rdx, rsp
   add rdx, 96             ; &inp_int
   call scanf
   mov rbx, [rsp+96]       ; inp_int = *inp_int
   mov [inp_int], rbx      ; store inp_int
   mov rcx, [rsp+88]       ; sum = a + b + c
   add rcx, rbx            ; sum += inp_int
   mov [rsp+88], rcx
   lea rcx, use_scanf_string2
   mov rdx, [rsp+64]       ; rdx = a
   mov r8, [rsp+72]        ; r8 = b
   mov r9, [rsp+80]        ; r9 = c
   mov [rsp+32], rbx       ; param 4 = inp_int
   mov rbx, [rsp+88]       ; param 5 = sum
   mov [rsp+40], rbx
   call printf
   add rsp, 56             ; dealloc shadow space
   mov rax, [rsp+32]       ; rax = sum
   ret


public max;;
;; rcx = _int64 a
;; rdx = _int64 b
;; r8  = _int64 c
max:
       sub rsp, 32
	   mov rax, rcx       ; _int64 v = a
	   cmp rdx, rax       ; b > v ?
	   jle max_1
	   mov rax, rdx       ; v = b
max_1: cmp r8, rax        ; c > v ?
       jle max_end
       mov rax, r8        ; v = c
max_end:
       add rsp, 32
       ret;

public max5
;; rcx = _int64 i
;; rdx = _int64 j
;; r8  = _int64 k
;; r9  = _int64 l
max5:
	   sub rsp, 32            ;; allocate shadow space
	   xor rax, rax
	   mov [rsp+8], r8        ; rsp+8 = k
	   mov [rsp+16], r9       ; rsp+16 = l
	   mov r8, rdx            ; r8 = j
	   mov rdx, rcx           ; rdx = i
	   mov rcx, inp_int       ; rcx = inp_int
	   call max               ; rax = max(inp_int, i, j)
	   mov rcx, rax           ; rcx = max(inp_int, i, j)
	   mov rdx, [rsp+8]       ; rdx = k
	   mov r8, [rsp+16]       ; r8 = l
	   call max
	   add rsp, 32            ;; deallocate shadow space
	   ret


;; address of the array: RDX
;; size of the array: RCX
public array_proc;;

array_proc:
		;; RAX is the accumulator
		xor rax, rax

		;; the main loop
L1:		add rax, [rdx] ;; access and add contents
		add rdx, TYPE QWORD	;; TYPE operator returns the number of bytes used by the identified QWORD
		loop L1 ;; RCX as the loop counter

		;; returning from the function/procedure
		ret

;; i in RCX (arg1)
;; j in RDX (arg2)
;; print_proc: adds the two arguments and prints it through printf
public print_proc

print_proc:
		lea rax, [rcx+rdx]		;; a way to add two regs and place it in rax
		mov [rsp+24], rax		;; preserving rax in shadow space
		mov [rsp+16], rcx		;; preserving i
		mov [rsp+8], rdx		;; preserving j

		;; Calling our printf function
		sub rsp, 40				;; the shadow space
		mov r9, rax				;; 4th argument
		mov r8, rdx				;; 3rd argument: j
		mov rdx, rcx			;; 2nd argument: i
		lea rcx, print_string	;; 1st argument: string
		call printf				;; call the function

		;; 2nd call to printf
		;; RSP has changed, so the displacements have also changed
		mov rax, [rsp+64]		;; restoring the sum
		add rax, bias			;; adding the bias
		mov [rsp+72], rax			;; preserving rax
		mov [rsp+32], rax		;; the 5th argument on stack
		mov r9, bias			;; the 4th argument
		mov r8, [rsp+48]		;; restoring j, the 3rd arg
		mov rdx, [rsp+56]		;; restoring i, the 2nd arg
		lea rcx, print_string2 ;; 1st argument: string
		call printf				;; call the function
		
		add rsp, 40				;; deallocate the shadow space
		
		;; restore rax
		mov rax, [rsp+32]
		ret

end