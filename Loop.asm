section .text
	global _start

_start:

	mov rax, 0
	mov rcx, 5
_sumar:
	add rax, 1
	loop _sumar

	mov rdi, rax
	mov rax, 60
	syscalls
