%include "imprimirNumero.asm"
section .text
    global _start

_start:
    xor rax, rax
    mov al, -45; cargamos el valor negativo a rax
    test al, al
    jns _positivo
    neg al
    
    ;;a este punto ya tenemos la certeza de que si es negativo
    ;;lo convertimos en positivo
    mov dil, al
    mov rsi, 1
    call imprimirNumero
    jmp fin
_positivo:
    mov rsi, 0
    mov dil, al
    call imprimirNumero
fin:
    xor rdi, rdi
    mov rax, 60
    syscall
