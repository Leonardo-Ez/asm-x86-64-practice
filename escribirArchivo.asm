section .data
    nombre db "archivoCreado.txt",0
    mensaje db "Hola desde mi lab 7",10
    largo equ $ - mensaje
section .text
    global _start
_start:
    ;abrir o crear el archivo
    mov rax, 2      ;open
    mov rdi, nombre ;nombre archivo
    mov rsi, 0x40   ;crear, si existe abrir
    mov rdx, 666o   ;
    syscall

    mov r8, rax     ;guardamos el fd, antes de que rax se reuse

    mov rax, 1          ; write
    mov rdi, r8         ;rdi = el fd que acabamos de abrir
    mov rsi, mensaje    ;rsi = dirección del texto
    mov rdx, largo      ;rdx = cantidad de bytes
    syscall

    ;cerrar el archivo
    mov rax, 3          ;close
    mov rdi, r8         ;el mismo fd
    syscall

    ;terminar el programa
    xor rdi, rdi
    mov rax, 60
    syscall