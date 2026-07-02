default rel
extern  GetStdHandle
extern  WriteFile
extern  ExitProcess

global  main

section .data
	text    db  "hello", 0
	text_len equ $ - text

section .bss
	bytes_written resd 1

section .text

	main:        
		sub rsp, 40               		
		mov rcx, -11                	
		call GetStdHandle

		mov     rcx, rax               
		lea     rdx, [text]             
		mov     r8d, text_len            
		lea     r9, [bytes_written] 
		mov     qword [rsp+32], 0       
		call    WriteFile   

		xor ecx, ecx
		call ExitProcess
