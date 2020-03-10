	AREA	AsmTemplate, CODE, READONLY
	IMPORT	main

; sample program makes the 4 LEDs P1.16, P1.17, P1.18, P1.19 go on and off in sequence
; (c) Mike Brady, 2011 -- 2019.

	EXPORT	start
start

	BL calculator

	B start


IO1DIR	EQU	0xE0028018	;Direction (Input or Output)
IO1SET	EQU	0xE0028014	;Logic High
IO1CLR	EQU	0xE002801C	;Logic Low
IO1PIN	EQU 0xE0028010	;Button


;getKey subroutine
;Parameters : R2: old value, R3: operator in queue
;Returns : R0 - Value of Pin Pressed eg. Press P1.20 R0 = 21
getKey
	STMFD sp!, {R4-R11,lr}	;save registers
	LDR R9, =0X00F00000
checkKey
	LDR R7, =IO1PIN		;Load 0xFFFF0000 into R1
	LDR R8, [R7]		;Store current value of pin

while
    AND R8, R8, R9
	CMP R8, R9
	BNE keypressed
	LDR R8, [R7]
	B while
keypressed

	LDR R4, =0X00F00000		; Load mask value to isolate pressed button
	AND R5, R8, R4
	MOV R5, R5, LSR #20		; Shift isolated bit to first bit
	CMP R5, #14				; if(input = firstPin) return 14! else check next val
	BNE checkPin2
	MOV R0, #20
	B doneGetKey
checkPin2
	CMP R5, #13
	BNE checkPin3
	MOV R0, #21
	B doneGetKey
checkPin3
	CMP R5, #11
	BNE checkPin4
	MOV R0, #22
	B doneGetKey
checkPin4
	CMP R5, #7
	BNE doneGetKey
	MOV R0, #23
doneGetKey

	LDR R11, =4000000
delay	subs	r11,r11,#1
	bne	delay
	
	LDR R6, =0
	LDR R10, =4000000
while2
    AND R8, R8, R9
	CMP R8, R9
	BEQ noPress
	ADD R6, R6, #1
	LDR R8, [R7]
	B while2
noPress
	CMP R6, R10
	BLT smallPress
	NEG R0, R0
smallPress

	LDMFD sp!,{R4-R11,pc}		;return register values	

;calculateNumber subroutine
;   runs an instance of calculator
;	Parameter: null
calculator

	STMFD sp!, {R4 ,lr}

    LDR R4, =0		; R4 = current number
    LDR R0, =0      ; R0 = input key number 
    LDR R1, =0		; R1 = number to display
    LDR R2, =0		; R2 = previous number
    LDR R3, =0		; R3 = previous operator

calc

	BL getKey

	CMP R0, #20
	BNE not_first_key_short_press
	ADD R4, R4, #1
	MOV R1, R4
not_first_key_short_press

	CMP R0, #21
	BNE not_second_key_short_press
	SUB R4, R4, #1
	MOV R1, R4
not_second_key_short_press

	CMP R0, #22
	BNE not_third_key_short_press
	CMP R3, #0
	BNE operation1
	MOV R2, R4
operation1
	CMP R3, #'+'
	BNE noAdd1
	ADD R2, R4, R2
noAdd1
	CMP R3, #'-'
	BNE noSub1
    SUB R2, R2, R4
noSub1
	MOV R3, #'+'
	LDR R4, =0
	MOV R1, R2
not_third_key_short_press

	CMP R0, #23
	BNE not_fourth_key_short_press
	CMP R3, #0
	BNE operation2
	MOV R2, R4
operation2
	CMP R3, #'+'
	BNE noAdd2
	ADD R2, R4, R2
noAdd2
	CMP R3, #'-'
	BNE noSub2
    SUB R2, R2, R4
noSub2
	MOV R3, #'-'
	LDR R4, =0
	MOV R1, R2
not_fourth_key_short_press

	CMP R0, #-22
	BNE not_third_key_long_press
	MOV R1, R2
	MOV R4, R2
	LDR R3, =0
not_third_key_long_press

	CMP R0, #-23
	BNE not_fourth_key_long_press
	LDR R1, =0
	BL display
	B calc_end
not_fourth_key_long_press	

	BL display

	B calc
calc_end

	LDMFD sp!, {R4 ,pc}

;display subroutine
;	displays whatever is in R1
;   Paramter: R1- value to be display
display
    STMFD sp!, {R4-r6 ,lr}

	ldr	r4,=IO1DIR
	ldr	r5,=0x000f0000	;select P1.19--P1.16
	str	r5,[r4]		;make them outputs
	ldr	r4,=IO1SET
	str	r5,[r4]		;set them to turn the LEDs off
	ldr	r5,=IO1CLR
; r1 points to the SET register
; r2 points to the CLEAR register

	MOV R6, R1, LSL #16	
	
	STR	r6,[r5]	   	; clear the bit -> turn on the LED

    LDMFD sp!, {R4-r6 ,pc}

stop	B	stop

	END