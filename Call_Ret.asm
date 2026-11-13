section .text
    global _start

_sumar:
    
    mov rax, rdi
    mov rbx, rsi

    push rdi
    push rsi

    add rax, rbx
    pop rsi
    pop rdi
    ret

_start:
    mov rdi, 6
    mov rsi, 9
    call _sumar

    mov rdi, rax
    mov rax, 60
    syscall




