extern malloc
extern free
extern fprintf

section .data

section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **

; int32_t strCmp(char* a, char* b) a = RDI, b = RSI
strCmp:
	PUSH RBP
	MOV RBP, RSP

	XOR RAX, RAX
	XOR R8, R8
	XOR R9, R9
	
	.loop:
		MOV R8B, [RDI]	
		MOV R9B, [RSI]
		
		CMP R8B, R9B
		JE .son_iguales
		JB .a_menor       ; unsigned: r8d > r9d
		JA .b_menor       ; unsigned: r8d < r9d


	.son_iguales: ; Si son iguales, hay que volver al loop
		test R8B, R8B
		JE .fin ;Salta si ya revise todo a

		INC RDI
		INC RSI
		jmp .loop

	.a_menor:
		MOV RAX, 1
		jmp .fin

	.b_menor:
		MOV RAX, -1
		jmp .fin

	.fin:
		POP RBP
		ret


; char* strClone(char* a)
strClone:
	push RBP
	MOV RBP, RSP
	PUSH RDI ; Me guardo en la pila el puntero al char

	call reservar
	MOV R9, RAX ;El puntero a la memoria reservada
	XOR R10, R10
	XOR R8, R8
	POP R8 ; Saco el puntero al char de la pila y lo pongo en R8
	PUSH R9 ; ME guardo el puntero al primer caracter copiado

	copiar:
		MOV R10B, [R8] ;Agarro el caracter de param
		test R10B, R10B
		JE finc
		MOV [R9], R10B
		ADD R9, 1
		ADD R8, 1
		JMP copiar

	finc:
		POP RAX
		POP RBP
		ret

; RDI: puntero a char
reservar:
	CALL strLen
	MOV RDI, RAX
	INC RDI
	CALL malloc
	RET

; void strDelete(char* a)
strDelete:
    call free
    ret

; void strPrint(char* a, FILE* pFile)
strPrint:
	ret

; uint32_t strLen(char* a)
strLen:
	push RBP
	MOV RBP, RSP
	XOR RAX, RAX
	
	coso:
		XOR R8, R8
		MOV R8B, [RDI]
		test R8B, R8B
		JE fin
		ADD RAX, 1
		ADD RDI, 1
		JMP coso

	fin:
		POP RBP
		ret

	


