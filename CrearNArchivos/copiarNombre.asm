copiarNombre:
    ;;tenemos la cadena de argumento en el rdi
    ;;tenemos el espacio en memoria en rsi
    xor rax, rax
bucle:
    mov bl, [rdi]
    cmp bl, 0;;si es 0 significa que es fin de cadena
    je _finCadena
    mov [rsi],bl;;copiamos el contenido de rdi en rsi
    inc rax
    inc rsi
    inc rdi
    jmp bucle
_finCadena:
    ;;
    mov byte [rsi],'0'
    inc  rsi
    mov byte [rsi],0
    ret;