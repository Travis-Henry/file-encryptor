section .data
	hello db "Hello, World!\n", 0
	ecryp db "encrypt", 0
	dcryp db "decrypt", 0 

section .text
	global _start

_start:
	push ebp		;function prologue
	mov ebp, esp


	mov eax, [esp]		;check if 4 args
	cmp eax, 4
	jne exit


	push dword [ebp+8]	;check mode
	call check_mode
	add esp, 4
	cmp eax, 0
	je encrypt
	cmp eax, 1
	je decrypt

	jmp exit_error		;exits if not enc or dec
	
	







	;This will print
	mov eax, 4
	mov ebx, 1
	lea ecx, hello    ;Address to string
	mov edx, 13	  ;Length of string
	int 0x80          ;I think this is a sys call

exit:				;Exit success
	mov eax, 1
	xor ebx,ebx
	int 0x80
exit_error:			;Exit fail
	mov eax, 1
	mov ebx, 1
	int 0x80

check_mode:			;returns 0 for enc
	push ebp		;1 for dec
	mov ebp, esp		;-1 for err






	ret


encrypt:
	push ebp		
	mov ebp, esp


	ret

decrypt:
	push ebp
	mov ebp, esp

	ret
