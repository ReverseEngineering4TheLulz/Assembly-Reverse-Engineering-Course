default rel
extern printf
global main

section .data
    format_f db "%f", 0
	; "%f" can be used for float and also for double:	
	; When a float is passed to a variadic function like printf for example the C standard requires default argument promotion: 
	; That means that the float gets promoted to a double BEFORE the function call. In C the compiler takes care of that and in Assembly its our job to do that.
	
	num_1 dq 1.12
	num_2 dq 2.34
	
section .text
main:
    sub rsp, 40    

	movsd xmm0, [num_1]
	movsd xmm1, [num_2]
	call AddFloatingPointNumbers
	movsd xmm1, xmm0   
	
	; call printf now accordingly to the Windows x64 bit calling convention
	lea rcx, [format_f]
	
	movq rdx, xmm1
	
    call printf 	; printf is a varadic function therefore we need to copy the floating-point value from xmm1 also to rdx.
	                ; In this case it would also work if the result would be in xmm0. But there is no guarantee that this works also with other
					; functions. Therefore its important to stick to the correct x64 windows calling convention.
	
	xor rax, rax    ; return 0
    add rsp, 40
    ret
	
AddFloatingPointNumbers:
	addsd xmm0, xmm1
	ret
	
	
