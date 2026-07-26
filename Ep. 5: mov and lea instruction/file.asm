default rel						; We want to use relative addressing.  More information can be found here: NASM doc page 104: 8.2.1 REL, ABS: RIP-relative addressing			
								      ; mov rax, [00007FF7D5281000]    Absolut addressing
								      ; mov rax, [rel text]			 Realtive adressing
extern  ExitProcess
global  main

section .data
	text db "hello", 0	  		; Byte string 
	text_length equ $ - text	; Define a constant value with the size of 6. 6 is the length of text + the nullterminator. More information can be found here: NASM doc page 38
	number dd 3			  		    ; Doubleword  (32-bit)

section .bss
	
section .text
	main:        
		sub rsp, 40               					
		mov rax, 1		    
		mov rcx, rax
		
		mov rax, text			  ; Move the address of text to rax
		lea rax, text			  ; Address of text to rax
		lea rax, [text]			; Address of text to rax	
		
		mov bl, byte [rax]	; Move the first byte from text to al	

		mov rax, 0				  ; Set rax to 0
		xor rax, rax			  ; Set rax to 0
				
		mov rax, number			; Move the address of number to rax
		lea rax, number			; Move the address of number to rax
		lea rax, [number]		; Move the address of number to rax
		mov rcx, [number]   ; Derefence number
		
		mov rax, text_length	; Mov the value 6 to rax
    xor rcx, rcx			; First function parameter for ExitProcess
    call ExitProcess



