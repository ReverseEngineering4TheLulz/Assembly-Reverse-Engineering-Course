default rel

extern printf
global main

section .data
	; printf("%s %s %f, %s %lld, %s %d, %s %f", text_m, text_d, num_d, text_i64, num_i64, text_i32, num_i32, text_f, num_f);
	format db "%s %s %f, %s %lld, %s %d, %s %f", 0
	text_m db "Mixed parameter example:", 0
	text_d db "Double:", 0
	text_i64 db "Int64:", 0
	text_i32 db "Int32:", 0
	text_f db "Float:", 0
	
	num_d dq 12.34
	num_i64 dq 456
	num_i32 dd 789
	num_f dd 21.43

section .text
main:
	sub rsp, 88	

	lea rcx, [format]
	lea rdx, [text_m]
	lea r8 , [text_d]	
	movsd xmm3, [num_d]
	movq r9, xmm3
	
	
	
	
	; Call from runtime to use code: call 00007FF64FFB12FA
	
	; Why its better to use r10 instead of a non-volatile register like rbx:
	; From the msdn: https://learn.microsoft.com/en-us/cpp/build/x64-software-conventions?view=msvc-170
	;
	; Volatile registers are scratch registers presumed by the caller to be destroyed across a call. 
	; Nonvolatile registers are required to retain their values across a function call and must be saved by the callee if used.
	; 
	; The main entrypoint gets called by the C-Runtime. The C-Runtime is the caller in this example and main is the callee.
	; The caller must assume that the non-volatile register will not be changed by a function call.
	;
	; Therefore using a volatile register like r10 and xmm4 is not a problem in this example. The caller can assume that the value in r10 and xmm4 gets changed inside of main.
	; If we want to use rbx and xmm6 anyway and want to stick to the calling convention then we need to make sure to restore rbx to its original value. (The value that it was holding before we have assigned a value).
	
	
	
	

	;lea rbx, [text_i64]
	;mov qword [rsp + 32], rbx
	;mov rbx, [num_i64]
	;mov qword [rsp + 40], rbx
	
	;lea rbx, [text_i32]
	;mov qword [rsp + 48], rbx
	;mov eax, [num_i32]
	;mov dword [rsp + 56], eax

	;lea rbx, [text_f]
	;mov qword [rsp + 64], rbx
	
	; movss xmm6, [num_f]
	; cvtss2sd xmm6, xmm6
	; movsd [rsp + 72], xmm6
	

	lea r10, [text_i64]
	mov qword [rsp + 32], r10
	mov r10, [num_i64]
	mov qword [rsp + 40], r10
	
	lea r10, [text_i32]
	mov qword [rsp + 48], r10
	mov eax, [num_i32]
	mov dword [rsp + 56], eax

	lea r10, [text_f]
	mov qword [rsp + 64], r10

	movss xmm4, [num_f]
	cvtss2sd xmm4, xmm4
	movsd [rsp + 72], xmm4
	call printf
	
	add rsp, 88
	xor rax, rax
	ret


