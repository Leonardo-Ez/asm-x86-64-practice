section .text
    global _start
_start:
    xor rax, rax; inicializamos en 0 el registro
    mov al, 237 ;cargamos 237 en al
    mov bl, 10  ;cargamos 10 en bl
    xor r8, r8
    ;;para el salto de linea:
    dec rsp
    mov [rsp], 10
    inc r8 
_sacarDigitos:
    div bl;dividimo al/bl
    ;;el residuo queda en ah
    ;;el resultado queda en al
    add ah, '0';;sacamos su caracter en assci    
    dec rsp             ; hacemos espacio de 1 byte en la pila (rsp baja 1)
    mov [rsp], ah        ; escribimos el carácter ahí, en memoria
    inc r8;
    cmp al, 0
    je _imprimir
    mov ah, 0
    jmp _sacarDigitos

_imprimir:
    ;;imprimimos
    mov rdx, r8             ; r8 bytes a escribir
    mov rsi, rsp            ;apuntamos a la pila
    mov rax, 1              ; syscall write
    mov rdi, 1               ; fd = 1 (stdout)
    syscall



fin:
    xor rdi, rdi
    mov rax, 60
    syscall

