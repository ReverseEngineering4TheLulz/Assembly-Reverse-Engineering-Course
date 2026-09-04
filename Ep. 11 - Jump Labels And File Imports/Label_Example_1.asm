default rel
extern ExitProcess
global main

section .text

main:					; Global Label
	sub rsp, 40
	xor rcx, rcx
	
	.count_up:			; Local Label
		inc rcx
		cmp rcx, 4
	jne .count_up
		
	xor rcx, rcx
	call MyFunction
	
	mov rcx, 4
	call MyFunction.count_down
	
	; we dont need to restore the rsp because ExitProcess will terminate the process
	xor rcx, rcx
	call ExitProcess
	
MyFunction:				; Global Label

	.count_up:			; It´s no problem if we use the same label name again. This is a Local Label.
		inc rcx
		cmp rcx, 3
	jne .count_up
	jmp .Finished
		
	.count_down:
		dec rcx
		cmp rcx, 0
		jne .count_down
		
	.Finished:
	ret
	