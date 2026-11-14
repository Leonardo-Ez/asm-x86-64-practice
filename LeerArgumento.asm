section .text
    global _start
_start:
    mov rbx, [rsp+16]
    mov al, [rbx]
    sub al, '0'
    xor rdi, rdi
    mov dil, al
    mov rax, 60
    syscall
