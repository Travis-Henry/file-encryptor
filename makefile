file-encryptor: main.o 
	ld -m elf_i386 -o file-encryptor main.o
main.o: main.asm
	nasm -f elf32 main.asm
clean:
	rm *.o
	rm file-encryptor
