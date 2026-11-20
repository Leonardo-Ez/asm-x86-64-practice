copiarNombre:
    ; Subrutina: copia una cadena (terminada en 0) de rdi a rsi,
    ; y deja en el buffer destino un '0' de relleno + terminador,
    ; listo para que el que llama sobreescriba ese '0' con un sufijo.
    ; Parametro 1 (rdi) = direccion de la cadena origen (ej. argv[1])
    ; Parametro 2 (rsi) = direccion del buffer destino
    ; Retorno (rax) = cantidad de caracteres copiados (posicion del sufijo)
    xor rax, rax          ; rax = 0, contador de caracteres copiados (se inicializa UNA sola vez)
bucle:                     ; cuerpo del bucle (separado del xor, para que no se reinicie cada vuelta)
    mov bl, [rdi]            ; bl = caracter actual de la cadena origen (1 byte)
    cmp bl, 0                  ; ¿es el caracter 0 (fin de cadena)?
    je _finCadena                ; si es 0, ya copiamos todo, saltamos a cerrar la cadena
    mov [rsi], bl                  ; copiamos ese caracter al buffer destino
    inc rax                          ; contador de caracteres copiados ++
    inc rsi                            ; avanzamos el puntero destino al siguiente byte
    inc rdi                              ; avanzamos el puntero origen al siguiente byte
    jmp bucle                              ; repetimos con el siguiente caracter
_finCadena:                                  ; aqui rsi apunta justo despues del ultimo caracter copiado
    mov byte [rsi], '0'                        ; dejamos un '0' (ASCII) como digito de sufijo por defecto
    inc rsi                                      ; avanzamos al siguiente byte
    mov byte [rsi], 0                              ; terminador de cadena (0, no el caracter '0')
    ret                                               ; retorna; rax = posicion del sufijo dentro del buffer

