section .data
    matriz db 1,2,3,4, 5,6,7,8, 9,10,11,12
section .text
    global _start

_start:
    mov rax, 2;;fila
    mov rdx,4;;num columnas
    mov rbx, matriz
    mov rcx, 1;;extra para pasar de columnas
    xor r8, r8;;acumulador
    imul rax, rax, 4;;multiplicamos para irnos al pos de la segunda columna
_sumar:
    add r8, [rbx+rax];;apuntamos en este caso al 9
    dec rdx
    cmp rdx, 0;;si ya llegamos a 4 saltamos al fin
    je _fin
    add rax, rcx
    jmp _sumar
_fin:    
    mov rdi, r8
    mov rax, 60
    syscall


