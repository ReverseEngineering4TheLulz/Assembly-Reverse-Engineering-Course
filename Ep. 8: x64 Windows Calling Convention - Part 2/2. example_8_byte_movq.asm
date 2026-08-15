default rel
extern ExitProcess
global main

section .data 
   number_1 dq 12.34
   number_2 dq 45.67

section .text

main:
	sub rsp, 40      
		
	movq xmm0, [number_1]
	movq xmm1, [number_2]
	
	addsd xmm1, xmm0
	movq rdx, xmm1
	
	xor ecx, ecx
	call ExitProcess