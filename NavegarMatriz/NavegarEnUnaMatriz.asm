section .data
    matriz db 1,2,3,4, 5,6,7,8, 9,10,11,12    ; fila 0, fila 1, fila 2
section .text
    global _start
_start:
    mov rax, 1;;fila
    mov rcx, 2;;columna

    ;;primero debemos estar en la fila correcta
    ;;dado que toda la matriz está ubicada como un arreglo
    ;;debemos poder navegar en ella

    ;;tendremos 2 casos, 

    imul rax, rax, 4    ;; multiplicamos por 4 para posicionarnos en la "fila" correcta
    add rax, rcx        ;;sumamos la columna para estar en el pos correcto

    ;;al final quedamos con la pos verdadera en rax :)

    mov rdx, matriz     ;;hacemos que rdx, apunte a la matriz
    mov bl, [rdx+rax]  ;;desplazamos y sacamos el contenido

    mov dil, bl
    mov rax, 60
    syscall



