.686                                ; create 32 bit code
.model flat, C                      ; 32 bit memory model
 option casemap:none                ; case sensitive


	.data

	public bias		;
	public bias2
	bias DWORD 4		;
	bias2 WORD 2
.code

public power;

power:
     ;; Prologue
     push ebp ;;push base point to stack
	 mov ebp, esp ;; establish stack frame
	 push esi ;; callee preserved
	 mov eax, 1
	 mov ebx, 1
	 mov ecx, [ebp+12] ;;  ecx = exponent
	 mov esi, [ebp+8] ;; ecx = base
P1:  mul esi
     add ebx, 1
	 cmp ebx, ecx
	 jle P1

	 pop esi ;;pop previous callee preserved
	;;Epilogue
	 mov esp, ebp
	 pop ebp
	 ret


public poly;
poly:
    ;; Prologue
    push ebp         ;;push base point to stack
	mov ebp, esp     ;;establish stack frame
	push esi         ;; callee preserved
	mov esi, [ebp+8] ;; x
	push 2           ;; exponent = 2
	push esi         ;; base = esi = x
	call power		 ;; eax = x^2
	;;eax returns x^2
	add eax, esi
	add eax, 1
	pop esi;; pop callee preserved

    ;;Epilogue
    mov esp, ebp
    pop ebp
	ret

mov eax, 1234          ; dividend low half
mov edx, 0             ; dividend high half = 0.  prefer  xor edx,edx

mov ebx, 10            ; divisor can be any register or memory

div ebx       ; Divides 1234 by 10.
        ; EDX =   4 = 1234 % 10  remainder
        ; EAX = 123 = 1234 / 10  quotient


public multiple_k_asm;
multiple_k_asm:
   ;;Prologue
   push ebp
   mov ebp, esp
   push si;
   push di;
   mov bx, [ebp+8] ;; N
   mov di, [ebp+12] ;; K
   mov esi, [ebp+16] ;; array
   xor cx, cx; i = 0
   ;;
MK_L1:   
   xor dx, dx ;; set dx = 0
   mov ax, cx ;; ax = i
   add ax, 1 ;; ax = i + 1
   div di ;; i+1%K
   cmp dx, 0
   jne MK_L2
   mov ax, 1
   mov [esi+2*ecx], ax
   jmp MK_L3
MK_L2: mov ax, 0
   mov [esi+2*ecx], eax
MK_L3:   
   add cx, 1 ;; i++
   cmp cx, bx ;; i < N ?
   jl MK_L1 ;; goto MK_L1
   pop si;
   pop di;
   ;;Epilogue
   mov esp, ebp
   pop ebp
   ret

public factorial;

factorial:
   ;prologue
   push ebp
   mov ebp, esp
   mov ebx, 1
   mov eax, [ebp+8] ;; N
   cmp eax, 1 ;; n == 0?
   jl FACT_1 ;; n == 0 => goto FACT_1
   ;;return n*factorial(n-1);
   mov ebx, eax
   push ebx
   dec eax
   push eax
   call factorial
   add sp, 4
   pop ebx
   mul ebx
   jmp FACT_2
FACT_1: mov eax, 1
   ;;Epilogue
FACT_2: mov esp, ebp
   pop ebp
   ret



;
; fib32.asm
;

;
; example mixing C/C++ and IA32 assembly language
;
; use stack for local variables
;
; simple mechanical code generation which doesn't make good use of the registers

public      fib_IA32a               ; make sure function name is exported

fib_IA32a:  push    ebp             ; push frame pointer
            mov     ebp, esp        ; update ebp
            sub     esp, 8          ; space for local variables fi [ebp-4] and fj [ebp-8]
            mov     eax, [ebp+8]    ; eax = n
            cmp     eax, 1          ; if (n <= 1) ...
            jle     fib_IA32a2      ; return n
            xor     ecx, ecx        ; ecx = 0   NB: mov [ebp-4], 0 NOT allowed
            mov     [ebp-4], ecx    ; fi = 0
            inc     ecx             ; ecx = 1   NB: mov [ebp-8], 1 NOT allowed
            mov     [ebp-8], ecx    ; fj = 1
fib_IA32a0: mov     eax, 1          ; eax = 1
            cmp     [ebp+8], eax    ; while (n > 1)
            jle     fib_IA32a1      ;
            mov     eax, [ebp-4]    ; eax = fi
            mov     ecx, [ebp-8]    ; ecx = fj
            add     eax, ecx        ; ebx = fi + fj
            mov     [ebp-4], ecx    ; fi = fj
            mov     [ebp-8], eax    ; fj = eax
            dec     DWORD PTR[ebp+8]; n--
            jmp     fib_IA32a0      ;
fib_IA32a1: mov     eax, [ebp-8]    ; eax = fj
fib_IA32a2: mov     esp, ebp        ; restore esp
            pop     ebp             ; restore ebp
            ret     0               ; return
    
;
; example mixing C/C++ and IA32 assembly language
;
; makes better use of registers and instruction set
;

public      fib_IA32b               ; make sure function name is exported

fib_IA32b:  push    ebp             ; push frame pointer
            mov     ebp, esp        ; update ebp
            mov     eax, [ebp+8]    ; mov n into eax
            cmp     eax, 1          ; if (n <= 1)
            jle     fib_IA32b2      ; return n
            xor     ecx, ecx        ; fi = 0
            mov     edx, 1          ; fj = 1
fib_IA32b0: cmp     eax, 1          ; while (n > 1)
            jle     fib_IA32b1      ;
            add     ecx, edx        ; fi = fi + fj
            xchg    ecx, edx        ; swap fi and fj
            dec     eax             ; n--
            jmp     fib_IA32b0      ;
fib_IA32b1: mov     eax, edx        ; eax = fj
fib_IA32b2: mov     esp, ebp        ; restore esp
            pop     ebp             ; restore ebp
            ret     0               ; return
    

	public array_proc 		; makes the procedure/function visible to C++ file
array_proc:
	;; Prologue
	;;  pushing the base pointer onto the stack
	push ebp
	;; establishing the stack frame
	mov ebp, esp

	;; Main function body
	;; Callee preserved ESI register
	push esi

	;; EAX is the accumulator
	xor eax, eax 		; clearing EAX

	;; Retreiving the arguments
	mov ecx, [ebp+12]
	mov esi, [ebp+8]

	;; the main loop
L1:	add eax, [esi] 		; accessing the array
	add esi, 4		; incrementing the pointer
	loop L1			; looping back to L1

	;; Retrieving ESI pushed earlier
	pop esi

	;; Epilogue
	mov esp, ebp
	pop ebp
	ret
end
