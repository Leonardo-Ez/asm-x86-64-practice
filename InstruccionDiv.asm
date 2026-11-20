section .text
    global _start
_start:
    xor rax, rax
    mov al, 237
    mov bl, 10
    div bl

    mov dil, al
    mov rax, 60
    syscall
