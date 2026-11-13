
%include "rutina.asm"

section .text
    global _start
_start:
    mov rax, 40
    call mi_rutina

    mov rdi, rax
    mov rax, 60
    syscall
