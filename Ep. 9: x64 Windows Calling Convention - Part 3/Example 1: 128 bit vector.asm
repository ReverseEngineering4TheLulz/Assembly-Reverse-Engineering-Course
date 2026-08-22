default rel

extern printf
global main

section .data
    format db "%f %f %f %f %f %f", 0
	vec_1 dq 1.5, 2.5 
    vec_2 dq 3.5, 4.2
	
	vec_3 dq 2.2, 3.3
	vec_4 dq 4.4, 5.5
	
section .bss	
    result resq 2

section .text
main:
    sub rsp, 56
	
    vmovupd xmm0, [vec_1]
    vmovupd xmm1, [vec_2]
		
    ; addpd  xmm0, xmm1
	; movupd [result], xmm0
	
	vaddpd xmm2, xmm0, xmm1                                                                 
    vmovupd [result], xmm2
	
	; first result
    lea rcx, [format]
    mov rdx, [result]        
    movq xmm1, rdx   	 ; moves the value of rdx in the corresponding floating point register   
						 ; (xmm1 is volatile so we are not violating the calling convention) 
						 ; If you dont know what that means then watch my calling convention part 2 video from 53:45min until the end.
						 ; Here is the direct link: https://www.youtube.com/watch?v=BK32M5KPGJM&t=53m45s
	
	; second result
    mov r8, [result + 8]       
    movq xmm2, r8     	 
				
	;-----------------------------
	
	; vec3 first number
	mov r9, [vec_3]
	movq xmm3, r9
	
	; vec3 second number					 
	mov r10, [vec_3 + 8]	 
	mov [rsp + 32], r10 					 
			 
	;-----------------------------
	
	; vec4 first number
	mov r10, [vec_4]		; r10 is also volatile so we can use it as a scratch (temporary) register.
	mov [rsp + 40], r10 
	
	; vec4 second number
	mov r10, [vec_4 + 8] 
	mov [rsp + 48], r10 
	
	;-----------------------------

    call printf
    add rsp, 56

    xor eax, eax
    ret
	
	
	


	
