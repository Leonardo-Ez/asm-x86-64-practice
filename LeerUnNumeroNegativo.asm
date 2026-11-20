section .text
    global _start
_start:
    mov rax, [rsp]
    cmp rax, 2
    jne _fin
    
    xor rax, rax

    mov rbx, [rsp+16];; scamos el puntero al primer argumento
    mov al, [rbx]  ;;Extraemos el primer byte del argumento
    cmp al, '-'
    jne _fin;;en este caso es un número positivo, entonces sigue el flujo de un positivo
    inc rbx;;nos posicionamos dónde ya se encuentra el número
    xor r8, r8
    xor rax, rax
_armarNumero:
    mov al, [rbx];;extraemos el primer número
    cmp al, 0;;
    je _finNegativo;;finalizamos el programa
    sub al, '0'
    imul r8, r8, 10;;multiplicamos por 10 el acumulado
    add r8, rax;;sumamos el digito actual
    inc rbx
    jmp _armarNumero
_finNegativo:
    neg r8;;el número negativo queda en r8 listo para ser usado
    
_fin:
    xor rdi, rdi
    mov rax, 60
    syscall    