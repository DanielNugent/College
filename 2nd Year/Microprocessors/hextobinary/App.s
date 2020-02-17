	AREA	AsmTemplate, CODE, READONLY
	IMPORT	main


	EXPORT	start
start


IO1DIR	EQU	0xE0028018
IO1SET	EQU	0xE0028014
IO1CLR	EQU	0xE002801C
NUM     EQU 0xFFFFFBE7
	;0x419
RAM EQU 0x40000000
BI EQU 0x3B9ACA00
MIL100 EQU 0x05F5E100
MIL10 EQU 0x00989680	
MIL EQU 0x000F4240
THOU100 EQU 0x000186A0
THOU10 EQU 0x00002710
THOU EQU 0x000003E8
HUND EQU 0x00000064
TEN EQU 0x0000000A
	
	
	;ldr	r1,=IO1DIR
	;ldr	r2,=0x000f0000	;select P1.19--P1.16
	;str	r2,[r1]		;make them outputs
;;	ldr	r1,=IO1SET
	;str	r2,[r1]		;set them to turn the LEDs off
;	ldr	r2,=IO1CLR
    LDR R7, =NUM
	TST R7, #0x80000000
	BEQ NOT_NEG
    MVN R7, R7
	ADD R7, R7, #1; 2's compliment
	LDR R6, =1; R6 = is negative = true
	B IS_NEG

NOT_NEG   LDR R6, =0; R6 = is negative = false
IS_NEG    LDR R5, =RAM
	LDR R4, =0 ; mem location
	LDR R2, =0 ; count BI
	LDR R8, =BI; remainder		
	B SBIL
BILAGAIN ADD R2, R2, #1; count++
SBIL SUB R7, R8
    CMP R7, #0
	BLE MIL100L
	B BILAGAIN
MIL100L  CMP R2, #0
	BNE skipZeroMil100
	LDR R2, =15
skipZeroMil100
     MOV R0, R2
	 BL flipBits
	 MOV R2, R0
     STRB R2, [R5,R4] ;MEM(R5 + R4) = R2
       LDR R2, =0 ; reset count to 0
       ADD R4, R4, #1 ; R4 ; mem loc ++
	   ADD R7, R7, R8; 
	   LDR R8, =MIL100; 
       	B SMIL100
MIL100AGAIN ADD R2, R2, #1; count++
SMIL100 SUB R7, R8
	   CMP R7, #0
	BLE MIL10L
	B MIL100AGAIN  
MIL10L	    CMP R2, #0
	BNE skipZeroMil10
	LDR R2, =15
skipZeroMil10
     MOV R0, R2
	 BL flipBits
	 MOV R2, R0
    STRB R2, [R5,R4] ;MEM(R5 + R4) = R2
    LDR R2, =0 ; reset count to 0
    ADD R4, R4, #1 ; R4 ; mem loc ++
	 ADD R7, R7, R8; 
	LDR R8, =MIL10; 
	B SMIL10
MIL10AGAIN ADD R2, R2, #1; count++
SMIL10 SUB R7, R8
		   CMP R7, #0
	BLE MILL
	B MIL10AGAIN  
MILL      CMP R2, #0
	BNE skipZeroMil
	LDR R2, =15
skipZeroMil 
     MOV R0, R2
	 BL flipBits
	 MOV R2, R0
    STRB R2, [R5,R4] ;MEM(R5 + R4) = R2
    LDR R2, =0 ; reset count to 0
    ADD R4, R4, #1 ; R4 ; mem loc ++
	   ADD R7, R7, R8; 
	LDR R8, =MIL; 
	B SMIL
MILAGAIN ADD R2, R2, #1; count++
SMIL SUB R7, R8
		   CMP R7, #0
	BLE THOU100L
	B MILAGAIN  
THOU100L     CMP R2, #0
	BNE skipZeroThou100
	LDR R2, =15
skipZeroThou100
     MOV R0, R2
	 BL flipBits
	 MOV R2, R0
    STRB R2, [R5,R4] ;MEM(R5 + R4) = R2
    LDR R2, =0 ; reset count to 0
    ADD R4, R4, #1 ; R4 ; mem loc ++
 ADD R7, R7, R8; 
	LDR R8, =THOU100; 
	B STHOU100
THOU100AGAIN ADD R2, R2, #1; count++
STHOU100 SUB R7, R8
		 CMP R7, #0
	BLE THOU10L
	B THOU100AGAIN
THOU10L     CMP R2, #0
	BNE skipZeroThou10
	LDR R2, =15
skipZeroThou10 
     MOV R0, R2
	 BL flipBits
	 MOV R2, R0
     STRB R2, [R5,R4] ;MEM(R5 + R4) = R2
    LDR R2, =0 ; reset count to 0
    ADD R4, R4, #1 ; R4 ; mem loc ++
    ADD R7, R7, R8; 
	LDR R8, =THOU10; 
	B STHOU10
THOU10AGAIN ADD R2, R2, #1; count++
STHOU10 SUB R7, R8
		 CMP R7, #0
	BLE THOUL
	B THOU10AGAIN
THOUL    CMP R2, #0
	BNE skipZeroThou
	LDR R2, =15
skipZeroThou 
     MOV R0, R2
	 BL flipBits
	 MOV R2, R0
     STRB R2, [R5,R4] ;MEM(R5 + R4) = R2
    LDR R2, =0 ; reset count to 0
    ADD R4, R4, #1 ; R4 ; mem loc ++
    ADD R7, R7, R8; 
	LDR R8, =THOU; 
	B STHOU
THOUAGAIN ADD R2, R2, #1; count++
STHOU SUB R7, R8
		 CMP R7, #0
	BLE HUNDL
	B THOUAGAIN
HUNDL     CMP R2, #0
	BNE skipZeroHund
	LDR R2, =15
skipZeroHund
     MOV R0, R2
	 BL flipBits
	 MOV R2, R0
     STRB R2, [R5,R4] ;MEM(R5 + R4) = R2
    LDR R2, =0 ; reset count to 0
    ADD R4, R4, #1 ; R4 ; mem loc ++
    ADD R7, R7, R8; 
	LDR R8, =HUND; 
	B SHUND
HUNDAGAIN ADD R2, R2, #1; count++
SHUND SUB R7, R8
		 CMP R7, #0
	BLE TENL
	B HUNDAGAIN
TENL
    CMP R2, #0
	BNE skipZeroTen
	LDR R2, =15
skipZeroTen  
      MOV R0, R2
	 BL flipBits
	 MOV R2, R0
   STRB R2, [R5,R4] ;MEM(R5 + R4) = R2
    LDR R2, =0 ; reset count to 0
    ADD R4, R4, #1 ; R4 ; mem loc ++
    ADD R7, R7, R8; 
	LDR R8, =TEN; 
	B STEN
TENAGAIN ADD R2, R2, #1; count++
STEN SUB R7, R8
		 CMP R7, #0
	BLE ONEL
	B TENAGAIN
	
ONEL  CMP R2, #0
	BNE skipZeroOne
	LDR R2, =15
skipZeroOne
     MOV R0, R2
	 BL flipBits
	 MOV R2, R0
   
    STRB R2, [R5,R4] ;MEM(R5 + R4) = R2
	
    LDR R2, =0 ; reset count to 0
    ADD R4, R4, #1 ; R4 ; mem loc ++
	ADD R7, R7, R8; 
	LDR R8, =1; 
	B SONE
ONEAGAIN ADD R2, R2, #1; count++
SONE SUB R7, R8
		 CMP R7, #0
	BLT DONE
	B ONEAGAIN
DONE  
    STRB R2, [R5,R4] ;MEM(R5 + R4) = R2
	LDR R3, =0
	ADD R4, R4, #1
	STRB R3, [R5, R4] ;null terminator
startLoop LDR R0, =RAM	
    LDR R1, =-1 ;counter
againLoopInit	ADD R1, R1, #1
	LDRB R2, [R0, R1]
	CMP R2, #15
	BEQ againLoopInit
	ADD R0, R0, R1 ;start of real
	;LOOP
	MOV R8, R0 ;
	LDR R9, =0
	ldr	r1,=IO1DIR
	ldr	r2,=0x000f0000	;select P1.19--P1.16
	str	r2,[r1]		;make them outputs
	ldr	r1,=IO1SET
	str	r2,[r1]		;set them to turn the LEDs off
	ldr	r2,=IO1CLR
againLoop	CMP R6, #1
	BEQ minus
wloop MOV R0, R8
     LDRB R7, [R0], #1
	 LSL R7, R7, #16
	 B floop
	  
	  
minus LDR R10, =11
      LSL R10, R10, #16
      STR R10, [R2]
     LDR R4, =4000000
minusLoop SUBS R4, R4, #1
     BNE minusLoop
	 STR R10, [R1]		;set the bit -> turn off the LED
	 B wloop
zero STR R9, [R2]
     LDR R4, =4000000
zeroLoop SUBS R4, R4, #1
     BNE zeroLoop
	 STR R9, [R1]		;set the bit -> turn off the LED
	 B againLoop
floop	STR R7, [R2]	   	; clear the bit -> turn on the LED
	;delay for about a half second
	LDR	r4,=4000000
dloop	SUBS	r4,r4,#1
	BNE	dloop ;timer
	STR	R7, [R1]		;set the bit -> turn off the LED
	LDRB R7, [R0], #1
	;EOR R7, R7, #0xF
	LSL R7, R7, #16	
	CMP R7, #0
	BNE	floop
	B	zero
	
	
L	B	L		; infinite loop to end programme

;R0 = register to flip LS 4 bits
flipBits AND R1, R0, #1
  AND R2, R0, #8
  LSR R2, R2, #3
  LSL R1, R1, #3
  LDR R3, =0
  ORR R3, R3, R1
  ORR R3, R3, R2
  AND R1, R0, #2
  AND R2, R0, #4
  LSR R2, R2, #1
  LSL R1, R1, #1
  ORR R3, R3, R1
  ORR R3, R3, R2
  MOV R0, R3
  BX LR
  

        END