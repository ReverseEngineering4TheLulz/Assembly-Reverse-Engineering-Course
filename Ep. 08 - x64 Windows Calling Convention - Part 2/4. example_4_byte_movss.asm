default rel
extern ExitProcess
global main

section .data 
   ; Single-floating-point = 32 Bit	(4 Byte)
   ; NASM stores the data as an IEEE-754 single-precision floating-point 
   number_1 dd 12.34
   number_2 dd 45.67

section .text

main:
    sub rsp, 40       


	movss xmm0, [number_1]
	movss xmm1, [number_2]
	
	addss xmm1, xmm0

	
	; Promote from float to double:
	;movq rdx, xmm1    Not allowed because xmm1 holds a single-precision-floating-point (32 bit) pattern in its low 32 bit. use cvtss2sd for the conversion. cvtss2sd = Convert single precision to double precision
	cvtss2sd xmm1, xmm1  ; Convert Scalar Single Precision Floating-Point Value to Scalar Double PrecisionFloating-Point Value
	movq rdx, xmm1       ; This is now allowed
	
	
	xor ecx, ecx
	call ExitProcess

		



	
	
	

