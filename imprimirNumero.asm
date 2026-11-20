imprimirNumero:
    xor rax, rax
    xor r8, r8
    mov al, dil
    mov bl, 10

    dec rsp
    mov byte [rsp],10
    inc r8
_cargarPila:
    div bl

    ;;en al quedó el resultado de la divición
    ;;en ah quedó el residuo
    add ah, '0'

    dec rsp;;hacemos un espacio de 1 byte
    mov [rsp],ah;;escribimos el digito en pila
    inc r8;;incrementamos el contador de caracteres  
    cmp al, 0;verificamos si quedan 0 caracteres
    je _imprimir;;si si saltamos a imprimir
    xor ah, ah;;si no inicializamos en 0 ah
    jmp _cargarPila
_agregar_negativo:
    dec rsp
    mov byte [rsp], '-'
    inc r8
    jmp _imprimirNumero
_imprimir:
    cmp rsi, 1
    je _agregar_negativo
_imprimirNumero:
    mov rax, 1
    mov rdi, 1
    mov rsi, rsp
    mov rdx, r8
    syscall

    add rsp, r8

    ret

