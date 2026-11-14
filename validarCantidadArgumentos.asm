section .text
    global _start
_start:
    xor rdi, rdi
    mov rbx, [rsp]
    cmp rbx,2
    jne _final
    mov rbx, [rsp+16]
    mov al, [rbx]
    sub al, '0'
    mov dil, al
    
_final:
    mov rax, 60
    syscall