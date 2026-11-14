section .text
    global _start

procesar:
    push rbx 
    ;guardamos el valor de rbx, 
    ;delegando a la subrutina esa responsabilidad
    mov rbx, 1
    add rbx, 200
    ;extraemos el valor de rbx de la pila
    ;antes de hacer ret
    pop rbx
    ret

_start:
    mov rbx, 999
    call procesar
    

    mov rdi, rbx
    mov rax, 60
    syscall

