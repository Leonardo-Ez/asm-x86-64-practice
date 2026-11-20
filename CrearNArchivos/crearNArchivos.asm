    %include "copiarNombre.asm"   ; pega aqui el codigo de la subrutina copiarNombre
section .bss
    buffer resb 32    ; reserva 32 bytes sin inicializar, para armar el nombre del archivo
section .text
    global _start      ; exporta _start para que el enlazador (ld) lo encuentre
_start:
    ; validamos que tengamos de entrada exactamente 3 argumentos en la pila de proceso
    mov rax, [rsp]         ; rax = argc (cuenta el nombre del programa + los 2 argumentos reales)
    cmp rax, 3                ; argc debe ser 3: programa + cadena base + numero
    je _sonIguales               ; si argc == 3, los argumentos son validos, seguimos
fin:                              ; punto de salida (tanto error de argumentos como exito)
    xor rdi, rdi                    ; codigo de salida = 0
    mov rax, 60                       ; syscall exit
    syscall                             ; termina el programa
_sonIguales:
    mov rdi, [rsp+16]    ; rdi = direccion de argv[1] (la cadena base, ej. "archivito")
    mov rsi, buffer        ; rsi = direccion del buffer (destino de la copia)
    call copiarNombre        ; copia la cadena base al buffer; al volver, rax = longitud copiada
    ; en rax tenemos la longitud de los caracteres copiados (posicion del sufijo)
    ; ya tenemos copiado en el buffer la cadena base, con un '0' de relleno + terminador al final

    ; recalculamos rsi para que apunte justo a la posicion del sufijo (se perdio durante el call)
    mov rsi, buffer       ; rsi = inicio del buffer otra vez
    add rsi, rax             ; rsi = buffer + longitud = posicion exacta del sufijo
    ; rsi ya deberia apuntar al '0' de relleno que dejo copiarNombre

    mov rdi, [rsp+24]    ; rdi = direccion de argv[2] (el numero de archivos, ej. "4")
    mov al, [rdi]           ; al = primer caracter de argv[2] (ej. '4', en ASCII)
    sub al, '0'                ; convertimos de ASCII a numero (al = 4)
    xor rcx, rcx                 ; limpiamos rcx (no se usa como contador final, solo de paso)
    mov r9b, al                     ; guardamos N en r9b: r9 no lo toca ningun syscall (a diferencia de rcx)
    mov bl, 1                         ; bl = contador de archivos (numerico), empieza en 1
    add bl, '0'                          ; convertimos el contador a su caracter ASCII ('1')
    mov r8, rsi                            ; guardamos en r8 la direccion del sufijo: sobrevive todo el bucle

crearArchivos:                               ; --- inicio del bucle: crea un archivo por cada vuelta ---
    ; escribimos el digito de sufijo actual en el nombre, dentro del buffer
    mov byte [r8], bl    ; buffer[posicion sufijo] = caracter actual (ej. '1', '2'...)

    ; abrimos (creamos) el archivo con el nombre que quedo armado en el buffer
    mov rax, 2              ; numero de syscall: open
    mov rdi, buffer            ; rdi = direccion del nombre completo (ej. "archivito1")
    mov rsi, 0x40                 ; rsi = flags: bit 6 encendido = crear el archivo si no existe
    mov rdx, 666o                    ; rdx = permisos en octal: lectura+escritura para todos
    syscall                             ; ejecuta open; rax queda con el file descriptor del archivo nuevo

    ; cerramos el archivo que acabamos de crear
    mov rdi, rax    ; rdi = el file descriptor que devolvio open
    mov rax, 3         ; numero de syscall: close
    syscall               ; ejecuta close

    sub bl, '0'    ; convertimos el contador de vuelta a numero, para poder compararlo con r9b

    cmp bl, r9b    ; comparamos el contador numerico contra N (la cantidad pedida)
    je fin            ; si son iguales, ya creamos los N archivos: terminamos
    inc bl               ; si no, contador numerico++
    add bl, '0'             ; lo convertimos otra vez a ASCII, para escribirlo en la siguiente vuelta
    jmp crearArchivos          ; repetimos el bucle
