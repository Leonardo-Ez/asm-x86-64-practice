section .data
    VECTOR dq 11, 14, 17, -18, -4, 22
section .text
    global _start

packed_sum:
    xor rax, rax
    mov rcx, rdi
_sumar:
    add rax, [rsi]
    add rsi, 8
    loop _sumar

    ret


_start:
    mov rdi, 6
    mov rsi, VECTOR
    call packed_sum

    mov rdi, rax
    mov rax, 60
    syscall
