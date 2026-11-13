section .text
    global _start

_start:
    mov al, 0b10101010
    xor al, 0b11111111

    xor rdi, rdi
    mov rax, 60
    syscall