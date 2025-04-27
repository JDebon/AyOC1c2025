

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
NODO_OFFSET_NEXT EQU 8
NODO_OFFSET_CATEGORIA EQU 8
NODO_OFFSET_ARREGLO EQU 8
NODO_OFFSET_LONGITUD EQU 8
NODO_SIZE EQU 8
PACKED_NODO_OFFSET_NEXT EQU 8
PACKED_NODO_OFFSET_CATEGORIA EQU 8
PACKED_NODO_OFFSET_ARREGLO EQU 8
PACKED_NODO_OFFSET_LONGITUD EQU 8
PACKED_NODO_SIZE EQU 8
LISTA_OFFSET_HEAD EQU 8
LISTA_SIZE EQU 8
PACKED_LISTA_OFFSET_HEAD EQU 8
PACKED_LISTA_SIZE EQU 8

;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS
global cantidad_total_de_elementos
global cantidad_total_de_elementos_packed

;########### DEFINICION DE FUNCIONES
;extern uint32_t cantidad_total_de_elementos(lista_t* lista);
;registros: lista[RDI]
cantidad_total_de_elementos:
	push RBP
	mov RBP, RSP

	XOR rax, rax
	MOV R8, [RDI] ;lista_t

	;next esta en $rdi
	;categoria esta en $rdi+8
	;arreglo esta en $rdi+16
	;longitud esta en $rdi+24
	
	coso:
	ADD RAX, [R8+24]
	MOV R8, [R8]
	TEST R8, R8
	jne coso


	pop RBP
	ret

;extern uint32_t cantidad_total_de_elementos_packed(packed_lista_t* lista);
;registros: lista[?]
cantidad_total_de_elementos_packed:
	push RBP
	mov RBP, RSP

	XOR rax, rax
	MOV R8, [RDI] ;lista_t

	;next esta en $rdi
	;categoria esta en $rdi+8
	;arreglo esta en $rdi+9 
	;longitud esta en $rdi+17
	
	cosoa:
	MOV EBX, [R8+17]
	ADD RAX, RBX
	MOV R8, [R8]
	TEST R8, R8
	jne cosoa


	pop RBP
	ret

