;===============================================================================
; PLANTILLA SCHIZONE (repo xmdi/SCHIZONE, comentarios en español)
;-------------------------------------------------------------------------------
; CÓMO USARLA:
;   1) Escribe tu código después de START: y antes de END:
;   2) Tus datos (db/dw/dd/dq) también van antes de END:
;   3) Las subrutinas se pegan con %include en la parte INCLUDES
;
; COMPILAR:
;   nasm -f bin prog.asm -o exe_prog
;   chmod +x exe_prog
;   ./exe_prog ; echo $?
;
; ⚠ GDB NO funciona con Schizone → para depurar, copia tu código a la
;   forma estándar (section .text / global _start / _start:).
;===============================================================================

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DEFINITIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; %define = macro de una línea (reemplazo de texto, NO es variable ni subrutina)
%define LOAD_ADDRESS 0x00020000		; dirección donde se carga el programa en memoria
%define CODE_SIZE END-(LOAD_ADDRESS+0x78)	; tamaño SOLO del código
						; = fin - inicio del código (0x78 = 120 = 64 + 56)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;HEADER;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

BITS 64				; directiva: generar código de 64 bits
org LOAD_ADDRESS		; directiva: las etiquetas empiezan a contar desde 0x20000

;--- ELF HEADER (64 bytes: offsets 0x00–0x3F del archivo) ------------------------
ELF_HEADER:
	db 0x7F,"ELF"		; número mágico: 7F 45 4C 46 ("\x7FELF")
	db 0x02			; clase: 2 = 64 bits
	db 0x01			; datos: 1 = little endian
	db 0x01			; versión de ELF
	db 0x09			; OS/ABI (Linux lo ignora)
	db 0x00			; versión de ABI
	times 7 db 0x00		; 7 bytes de relleno (times = repetir)
	dw 0x0002		; tipo: 2 = ejecutable
	dw 0x003E		; máquina: 0x3E = AMD x86-64
	dd 0x00000001		; versión 1
	dq START		; e_entry: dirección donde empieza el programa (START)
	dq 0x0000000000000040	; dónde está el program header (byte 64)
	dq 0x0000000000000000	; section headers: no hay (por eso GDB no funciona)
	dd 0x00000000		; flags
	dw 0x0040		; tamaño del ELF header = 64
	dw 0x0038		; tamaño de cada program header = 56
	dw 0x0001		; cantidad de program headers = 1
	dw 0x0000		; tamaño de section header (no hay)
	dw 0x0000		; cantidad de section headers = 0
	dw 0x0000		; índice de nombres de secciones (no hay)

;--- PROGRAM HEADER (56 bytes: offsets 0x40–0x77) -------------------------------
PROGRAM_HEADER:
	dd 0x00000001		; tipo: 1 = segmento que se carga en memoria
	dd 0x00000007		; permisos: leer + escribir + ejecutar
	dq 0x0000000000000078	; en el ARCHIVO el código empieza en el byte 0x78
	dq LOAD_ADDRESS+0x78	; en MEMORIA el código empieza en 0x20078
	dq 0x0000000000000000	; dirección física (se ignora)
	dq CODE_SIZE		; tamaño del código en el archivo
	dq CODE_SIZE		; tamaño del código en memoria
	dq 0x0000000000000000	; alineación (no importa)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;INCLUDES;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; aquí van los %include "subrutina.asm" (quedan ANTES del código principal)
	%include "convertir.asm"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;INSTRUCTIONS;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

START:				; aquí empieza a ejecutarse (lo dice e_entry en el header)
	;;primero validamos que tenga 2 argumentos
	mov rax, [rsp];apuntamos a la cantidad de argumentos
	
	cmp rax, 2; validamos que exista contenido, es con 2, por que también cuenta le argumento
	;;de nombre de ejecutable
	jne _noexisteArgumentos
	mov rdi, [rsp+16]
	call convertir
	mov rdi, rax
	mov rax, 60
	syscall

_noexisteArgumentos:
	mov rdi, 0xff; si son diferentes entonces sale con 0xff
	mov rax, 60
	syscall
END:
