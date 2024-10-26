section .data
	hello db "Hello, World!", 0
section .text
	global _start

_start:
	;this is a comment, weird...
	mov eax, 4
	mov ebx, 1
	lea ecx, [hello]
	mov edx, 13
	int 0x80          ;I think this is a sys call

	;Exit program
	mov eax, 1
	xor ebx,ebx
	int 0x80
