section .text
    global _start

procesar:
    mov rbx, 1
    add rbx, 200
    ret

_start:
    mov rbx, 999
    push rbx 
    ;guardamos el valor de rbx, 
    ;siendo nosotros los que protegemos la variable
    call procesar
    ;extraemos el valor de rbx de la pila
    pop rbx

    mov rdi, rbx
    mov rax, 60
    syscall

