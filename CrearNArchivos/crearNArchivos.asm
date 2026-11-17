    %include "copiarNombre.asm"
section .bss
    buffer resb 32    ; reserva 32 bytes, sin inicializar, etiquetados como "buffer"
section .text
    global _start
_start:
    ;;validamos que tengamos de entrada más de 2 argumentos
    mov rax, [rsp]
    cmp rax, 3
    je _sonIguales
fin:
    xor rdi, rdi
    mov rax, 60
    syscall
_sonIguales:
    mov rdi, [rsp+16];;apuntamos a la parte donde se encuentra el número
    mov rsi, buffer
    call copiarNombre
    ;;en rax, tendremos de retorno la longitud de los caracteres
    ;;ya tenemos copiado en la memoria reservada la cadena base
    ;;en la forma

    ;;actualizamos rsi

    mov rsi, buffer
    add rsi, rax
    ;;rsi ya debería apuntar al 0 de antes
    mov rdi, [rsp+24]
    mov al, [rdi];;sacamos la cantidad de archivos
    sub al, '0'
    xor rcx, rcx
    mov r9b,al;copiamos para usarlo de contador
    mov bl, 1
    add bl,'0'
    mov r8, rsi
crearArchivos:
    ;;cambiamos el nombre 
    mov byte [r8],bl
    ;;crear archivo
    mov rax, 2;;crear archivo
    mov rdi, buffer;;apuntamos al nombre
    mov rsi, 0x40; crear o abrir
    mov rdx, 666o
    syscall

    
    ;;cerrar archivo
    mov rdi, rax
    mov rax, 3
    syscall
     
    sub bl, '0'


    cmp bl,r9b
    je fin
    inc bl
    add bl, '0'
    jmp crearArchivos
