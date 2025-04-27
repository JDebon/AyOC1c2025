%define SYS_WRITE 1     ;;
%define SYS_EXIT 60     ;; Directivas de preprocesador
%define STDOUT 1        ;;

section .data           ;;--> Directiva de ensamblador          ;;
msg db '¡Hola Mundo!', 10   ;;--> Pseudo-instrucciones          ;; Sección .data
len EQU $ - msg             ;;                                  ;; 

global _start           ;;--> Directivas de ensamblador
section .text           ;;                                      ;;
_start:                                                         ;;
    mov rax, SYS_WRITE                                          ;;
    mov RDI, STDOUT                                             ;;
    mov rsi, msg                                                ;;
    mov rdx, len                                                ;; Sección .text
    syscall                                                     ;;
                                                                ;;
    mov rax, SYS_EXIT                                           ;;
    mov rdi, 0                                                  ;;
    syscall            