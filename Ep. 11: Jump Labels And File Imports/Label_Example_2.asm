default rel
extern ExitProcess
global main
  
section .text

	main:
	sub rsp, 40
	xor rcx, rcx
	
	jmp function.Label_1
	jmp function.Label_4
	
	.back:		
		inc rcx
		cmp rcx, 2
		je .finished

	; We can also jump immediately to function.Label_1.Label_2.Label_3 
	jmp function.Label_1.Label_2.Label_3
	
	.finished:
	
	xor rax, rax
	call ExitProcess

function:
					
	.Label_1:
		mov rax, 1
		jmp .Label_1.Label_2
		
		.Label_1.Label_2.Label_3:
			mov rax, 3
			jmp main.back
						
		.Label_1.Label_2:
		mov rax, 2
			
		jmp .Label_1.Label_2.Label_3
		
	.Label_4:
		mov rax, 4
		jmp main.back
		