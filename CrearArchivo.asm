section .data
    nombre db "archivoCreado.txt", 0
section .text
    global _start
_start:
    mov rax, 2;syscall open
    mov rdi, nombre;nombre del archivo con 0 como fin de cadena
    mov rsi, 0x40; "crealo si no existe"
    mov rdx, 0666; permisos de lectura escritura para todos

    syscall; despues de esto, rax ya tiene el descriptor guardado

    mov rbx, rax;copiamos el valor en otro registro


    mov rax, 3; syscall de cerrar
    mov rdi, rbx; mandamos a rdi el descriptor del archivo
    syscall;cerramos el archivo haciendo una llamada al sistema

    xor rdi, rdi
    mov rax, 60;syscall para finalizar
    syscall