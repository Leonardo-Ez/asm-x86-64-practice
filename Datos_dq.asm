section .data
    VECTOR dq 3,5,8,2
section .text
    global _start

_start:
    mov rsi, VECTOR
    mov rcx, 4
    xor rax, rax

_sumar:
    add rax, [rsi]
    add rsi, 8
    loop _sumar


    mov rdi, rax
    mov rax, 60
    syscall
