section .data
	hello db "Hello, World!", 0xA, 0
	ecryp db "encrypt", 0
	dcryp db "decrypt", 0 
	err db "There was an error", 0xA, 0

section .text
	global _start

_start:
	push ebp		;function prologue
	mov ebp, esp


	mov eax, [ebp+4]	;check if 4 args
	cmp eax, 4
	jne exit_fail


	mov esi, [ebp+12]
	push esi				;check mode
	call check_mode
	add esp, 4
	cmp eax, -1
	je exit_fail

		;TODO
	
	







	;This will print
	mov eax, 4
	mov ebx, 1
	lea ecx, hello    ;Address to string
	mov edx, 14	  ;Length of string
	int 0x80          ;I think this is a sys call

exit_success:				;Exit success
	mov eax, 1
	xor ebx,ebx
	int 0x80
exit_fail:				;Exit fail


	
	mov eax, 4
	mov ebx, 1
	lea ecx, err    	;Address to string
	mov edx, 19		  ;Length of string
	int 0x80
	
	mov eax, 1
	mov ebx, 1
	int 0x80

check_mode:			;returns 0 for enc
	push ebp		;1 for dec
	mov ebp, esp		;-1 for err
	

	lea esi, ecryp
	mov edi, [ebp+8]


	push esi		;compare encrypt
	push edi
	call strcmp
	add esp, 8		
	
	cmp eax, 0
	je .encrypt

	
	lea esi, dcryp
	mov edi, [ebp+8]

	push esi		;compare decrypt
	push edi
	call strcmp
	add esp, 8

	cmp eax, 0
	je .decrypt
	
	mov eax, -1		;error
	jmp .done
	
	.encrypt:
		mov eax, 0
		jmp .done
	.decrypt:
		mov eax, 1
		jmp .done
	.done:
		mov esp, ebp		;function epilogue
		pop ebp
		ret

strcmp:					;if eql ret 0 else 1
	push ebp			;function prologue
	mov ebp, esp

	mov esi, [ebp + 8]		;load params into reg
	mov edi, [ebp + 12]
	
	
	.loop:
		mov al, [esi]		;grab one char		
		mov bl, [edi]		
		cmp al, bl		
		jne .not_equal
		cmp al, 0		;test if null
		je .equal
		inc esi
		inc edi
		jmp .loop

	.equal:
		xor eax, eax
		jmp .done
	.not_equal:
		mov eax, 1
		jmp .done
	.done:	
	mov esp, ebp			;function epilogue
	pop ebp
	ret


encrypt:
	push ebp		
	mov ebp, esp


	ret

decrypt:
	push ebp
	mov ebp, esp

	ret
