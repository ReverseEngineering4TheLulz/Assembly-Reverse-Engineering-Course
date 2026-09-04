default rel

extern printf
global main

section .data
    format db "%f %f", 0
	vec_1 dd 1.5, 2.5  
 	vec_2 dd 3.1, 4.1 
	
section .bss
	result resq 2	  
		
section .text
main:
    sub rsp, 40
	
    movq xmm0, [vec_1]
    movq xmm1, [vec_2]

    addps xmm0, xmm1		; Add packed single precision floating point values. 
    cvtps2pd xmm0, xmm0		; Convert Packed Single Precision Floating-Point Values to Packed Double PrecisionFloating-Point Values
							; Convert a 64 bit vector into a 128 bit vector. (We need to convert from 64 bit to 128 bit because we use printf 
							; to print the result and printf works always with double precision floating point values)
	

	movupd [result], xmm0
	
    lea rcx, [format]

    movupd xmm1, [result]	  
    movq rdx, xmm1          ; movq moves the low part of xmm1 to rdx. (xmm1 = 4.5, the first value of vec_1 + the first value of vec_2 = 4.5)

    movupd xmm2, xmm1       ; xmm2 holds the whole result from the vector calculation
    unpckhpd xmm2, xmm2	    ; Unpack and Interleave High Packed Double Precision Floating-Point Values
	                        ; moves the high part from xmm2 (6.5) to the low part of xmm2. Then with mov r8, xmm2 we load the low part (4.5) of xmm2 to r8.
    movq r8, xmm2

    call printf

    add rsp, 40
    xor eax, eax
    ret
