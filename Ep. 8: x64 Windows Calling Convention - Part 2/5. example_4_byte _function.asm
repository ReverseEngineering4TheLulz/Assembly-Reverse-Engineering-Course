default rel
extern printf
global main

section .data
    format_f db "%f", 0
    num_1 dd 1.12
    num_2 dd 2.34

section .text
main:
    sub rsp, 40

    movss xmm0, [num_1]
    movss xmm1, [num_2]

    call AddFloatingPointNumbers
	
    lea rcx, [format_f]
	movsd xmm1, xmm0        ; xmm0 is now a double so using movsd is correct
    movq rdx, xmm0
    call printf

    xor rax, rax
    add rsp, 40
    ret

AddFloatingPointNumbers:
    addss xmm0, xmm1
	cvtss2sd xmm0, xmm0    ; Convert Scalar Single Precision Floating-Point Value to Scalar Double PrecisionFloating-Point Value
    ret

