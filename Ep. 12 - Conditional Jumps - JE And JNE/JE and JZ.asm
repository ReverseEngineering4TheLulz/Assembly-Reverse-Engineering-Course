;When does it make sense to use JE and when jz:

;Example 1:

;cmp rax, rbx
;je .is_equal

;Example 2:

;test rax, rax
;jz .is_equal

;Example 3:

;.counter
;dec rcx       ; if rcx=0 then dec sets the ZF flag to 1. If rcx is 0 and we execute inc rcx the rcx=1 and ZF=0.
;jnz .counter


default rel
extern printf
global main
  
section .data
	format    db "%s", 0
	equal     db"rax and rcx are equal", 0
	not_equal db "rax and rcx are NOT equal", 0
	
section .text
	main:
	sub rsp, 40
	xor rcx, rcx
	
	mov rax, 4
	mov rcx, 4
	cmp rax, rcx         			; ZF is 1 if rax equal rcx
	je .rax_and_rcx_are_equal		; je jumps if ZF = 1
	jne .rax_and_rcx_are_not_equal  ; jne jumps if ZF = 0
		
.rax_and_rcx_are_equal:
	lea rcx, [format]
	lea rdx, [equal]
	call printf
	jmp .finished

.rax_and_rcx_are_not_equal:
	lea rcx, [format]
	lea rdx, [not_equal]
	call printf
	
.finished:
	
	xor rax, rax
	add rsp, 40
	ret
