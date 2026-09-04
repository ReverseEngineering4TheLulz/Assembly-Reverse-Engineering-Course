default rel
extern GetCursorPos
extern printf
global main

struc POINT
	.x resd 1
	.y resd 1
endstruc

section .data
	format db "X: %d, Y: %d", 0xa, 0
	
section .bss
	point resb POINT_size    ; If we use: StructureName_size then NASM will calculate the size of the structure for us.
	                         ; The size of the POINT structure is 64 bit. resd = Reserve dword. 1 dword = 32 bit.
	
section .text
	main:
		sub rsp, 40
		
	.Lab_1:
	
		lea rcx, [point]
		call GetCursorPos
		
		lea rcx, [format]
		mov edx, [point + POINT.x]
		mov r8d, [point + POINT.y]
		call printf
		
	jmp .Lab_1
		
		add rsp, 40
		ret
