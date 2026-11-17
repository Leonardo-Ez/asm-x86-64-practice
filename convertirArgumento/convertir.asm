convertir:
    xor rax, rax
_loop:
    xor rbx, rbx;;inicializamos en 0
    mov bl,[rdi];;copiamos el valor del contenido
    cmp bl, 0;;comparamos que no sea fin de cadena
    je iguales;en caso de iguales, saltamos al fin
    sub bl, '0';restamos '0' para tener su valor real
    imul rax,rax,10;;multiplicamos por 10
    add rax, rbx;lo agregamos al acumulador
    add rdi, 1;;movemos el puntero de rdi 8 bits, 1 byte
    jmp _loop

iguales:
    ; si llegamos aquí significa que llegamos al caracter 0
    ret