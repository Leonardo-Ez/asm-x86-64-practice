section .text
    global _start


_start:
    mov rax, 11
    mov rbx, 22

    push rax
    push rbx

    mov rax, 32
    mov rbx, 53

    pop rbx
    pop rax

    mov rdi, rax
    mov rax, 60
    syscall