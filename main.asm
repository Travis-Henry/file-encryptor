section .data
	hello db "Hello, World!", 0xA, 0
	ecryp db "encrypt", 0
	dcryp db "decrypt", 0 
	err db "There was an error", 0xA, 0
	buffer_size dd 256
section .bss
	buffer resb 256		;this sectin is for uninitialized variables

section .text
	global _start

_start:
	push ebp		;function prologue
	mov ebp, esp
	sub esp, 4		;[ebp-4] is mode

	mov eax, [ebp+4]	;check if 4 args
	cmp eax, 4
	jne exit_fail


	mov esi, [ebp+12]	;check mode
	push esi			
	call check_mode
	add esp, 4
	cmp eax, -1
	je exit_fail
	mov dword[ebp-4], eax	;store mode in local variable


	mov esi, [ebp+16]	;encrypt/decrypt
	mov edi, [ebp+20]
	push esi
	push edi
	call encrypt_decrypt
	add esp, 8





	;TODO rename file
	
	















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


encrypt_decrypt:
	push ebp			;function prologue	
	mov ebp, esp
	sub esp, 12			;ebp-4 is i for the key
					;ebp-8 is the file descriptor
					;ebp-12 is for bytes read

	mov eax, 5			;open a file
	mov ebx, [ebp+8]		;ebp+8 is the file name
	mov ecx, 66              	; O_RDWR | O_TRUNC this will allow overwriting
	int 0x80
	mov esi, eax			;store file descriptor
	cmp eax, 0
	jl exit_fail
	
	.loop:
		
		mov eax, 3		;reads into a buffer
		mov ebx, esi	        ;file descriptor
		mov ecx, buffer
		mov edx, [buffer_size]
		int 0x80

		mov [ebp-12], eax
		mov ecx, eax		;eax will hold how much was read

		test eax, eax
		je .close
		
		mov eax, 19             ;moves the file pointer back
		mov ebx, esi            ;file descriptor
		neg ecx                 ;offset
		mov edx, 1              ;SEEK_SET 1 is based of current
		int 0x80          
		neg ecx			;resets ecx back
			
		.xor:
			xor byte [buffer + ecx - 1], 0xFA  ;temp value for key
			dec ecx
			jns .xor
	

		
		mov eax, 4		;writes to a file		
		mov ebx, esi
		mov ecx, buffer
		mov edx, [ebp-12]
		int 0x80

		jmp .loop	


	.close:

	mov eax, 6			;this is to close the file
	mov ebx, esi
	int 0x80


	mov esp, ebp			;function epilogue
	pop ebp
	ret
