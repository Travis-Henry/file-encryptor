---

# File Encryptor

File Encryptor is a command-line program written in x86 Assembly (ASM) that encrypts or decrypts any file using a given password. This project was created as part of the 2024 RowdyHacks Hackathon and significantly expanded my understanding of assembly language.

## Features
- **Encrypt/Decrypt Any File**: Uses XOR encryption with a custom, rotating key to secure any file.
- **Command-Line Based**: Lightweight and efficient for command-line environments.
- **Educational Journey**: A deeper dive into Assembly for low-level programming enthusiasts!

![Before](/before.png)
![After](/after.png)


## Getting Started

### Prerequisites
- **NASM**: Ensure that the Netwide Assembler (NASM) is installed on your system.

### Setup
1. Clone this repository:
   ```bash
   git clone <repo_url>
   ```
2. Run the `make` command to compile the program:
   ```bash
   make
   ```
3. Place the file you want to encrypt in the same directory as the program.

## Usage
To encrypt or decrypt a file, run:
```bash
./file-encryptor <mode> <file_path> <password>
```
- **mode**: Specify `encrypt` or `decrypt`.
- **file_path**: Path to the file you want to secure.
- **password**: The encryption key, which can be any string.

## Project Overview
I took on this project with only limited knowledge of assembly, having briefly encountered inline assembly in a Computer Organization class. This hackathon gave me a chance to dive into ASM in-depth and work through challenges on the fly.

### Development Journey
1. **Assembler Choice**: I chose NASM for its rich documentation and ease of use in assembly projects.
2. **Hello World**: Started by learning the basics with a "Hello World" program to get comfortable with assembly, compilation, and linking.
3. **Makefile**: Created a Makefile to streamline compiling.
4. **Sections**: Learned about different sections like `.text` and `.data` to manage code and data.
5. **Command Line Arguments**: Gained experience with the cdecl calling convention and handling command-line arguments.
6. **Encrypt/Decrypt Mode**: Implemented XOR encryption, realizing later that XOR is symmetric—encryption and decryption work identically.
7. **Encryption Function**: Wrote the main encryption/decryption logic, using system calls to handle file operations in ASM.
8. **Rotating Key**: Started with a single-byte key and then expanded it to support a rotating key for more robust encryption.

![Alt text](/debugging.png)


### Reflections
This project was both challenging and rewarding. I faced moments of doubt but ultimately came away with a much deeper understanding of low-level programming and assembly language.

## Future Improvements
- Improve variable management to streamline the code further.
- Add a custom file extension for encrypted files to distinguish them more easily.
- Expand the encryption algorithm for added security.

## Acknowledgments
Thank you to the organizers of RowdyHacks 2024, UTSA and the ASM community for the resources and support throughout this project!

---
