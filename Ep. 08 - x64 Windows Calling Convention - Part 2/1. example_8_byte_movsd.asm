default rel
extern ExitProcess
global main

section .data 
   ; Double-precision-floating-point = 64 Bit (8 Byte)
   ; NASM stores the data as an IEEE-754 double-precision floating-point. 
   ; The IEEE-754 standard describes how to encode floating point values in binary.
   number_1 dq 12.34
   number_2 dq 45.67

section .text

main:
    sub rsp, 40       
	movsd xmm0, [number_1]
	movsd xmm1, [number_2]

	addsd xmm1, xmm0
	
	movq rdx, xmm1

	movq xmm0, xmm1
	movsd xmm0, xmm1

	xor ecx, ecx
	call ExitProcess

	; movsd =  Move Scalar Double Precision Floating-Point Value
	; movq  = Move Quadword
	; addsd = Add Scalar Double Precision Floating-Point Values
	
	; Allowed:
	; movsd xmm0, xmm1        		XMM register -> XMM register
	; movsd xmm0, [var1]      		64-bit variable -> XMM register
	; movsd [variable], xmm0  		XMM register -> 64-bit variable
	
	; Not allowed:
	; movsd rdx, xmm0         		Use movq rdx, xmm0
	; movsd rax, rdx		  		Use mov rax, rdx
	; movsd [variable1], [variable2]
	
	
	; Allowed
	; movq xmm0, xmm1       		xmm register to xmm register
	; movq xmm0, [variable]       	64-bit variable to XMM register
	; movq [variable], xmm0       	xmm register to 64-bit memory (instead of [register]. This is also valid: [64 bit variable]
	; movq xmm0, rdx         		General purpose to xmm
	; movq rax, xmm0         		xmm register to general purpose register
	
	; Not allowed:
	; movq rax, rdx  		 		Use mov rax, rdx
	; movsd [var1], [var2]
	
	
	; Allowed:
	; addsd xmm1, xmm0  		xmm0 register to xmm register
	; addsd xmm1, [variable]	64bit variable to xmm register
	
	; Not allowed:
	; addsd [number_1], xmm1
	; addsd [number_2], [number_1]

	


	
	

