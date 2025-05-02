extern malloc

section .rodata
; Acá se pueden poner todas las máscaras y datos que necesiten para el ejercicio

section .text
; Marca un ejercicio como aún no completado (esto hace que no corran sus tests)
FALSE EQU 0
; Marca un ejercicio como hecho
TRUE  EQU 1

; Marca el ejercicio 1A como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - es_indice_ordenado
global EJERCICIO_1A_HECHO
EJERCICIO_1A_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

; Marca el ejercicio 1B como hecho (`true`) o pendiente (`false`).
;
; Funciones a implementar:
;   - indice_a_inventario
global EJERCICIO_1B_HECHO
EJERCICIO_1B_HECHO: db TRUE ; Cambiar por `TRUE` para correr los tests.

;########### ESTOS SON LOS OFFSETS Y TAMAÑO DE LOS STRUCTS
; Completar las definiciones (serán revisadas por ABI enforcer):
ITEM_NOMBRE EQU 0
ITEM_FUERZA EQU 20
ITEM_DURABILIDAD EQU 24
ITEM_SIZE EQU 28

;; La funcion debe verificar si una vista del inventario está correctamente 
;; ordenada de acuerdo a un criterio (comparador)

;; bool es_indice_ordenado(item_t** inventario, uint16_t* indice, uint16_t tamanio, comparador_t comparador);

;; Dónde:
;; - `inventario`: Un array de punteros a ítems que representa el inventario a
;;   procesar.
;; - `indice`: El arreglo de índices en el inventario que representa la vista.
;; - `tamanio`: El tamaño del inventario (y de la vista).
;; - `comparador`: La función de comparación que a utilizar para verificar el
;;   orden.
;; 
;; Tenga en consideración:
;; - `tamanio` es un valor de 16 bits. La parte alta del registro en dónde viene
;;   como parámetro podría tener basura.
;; - `comparador` es una dirección de memoria a la que se debe saltar (vía `jmp` o
;;   `call`) para comenzar la ejecución de la subrutina en cuestión.
;; - Los tamaños de los arrays `inventario` e `indice` son ambos `tamanio`.
;; - `false` es el valor `0` y `true` es todo valor distinto de `0`.
;; - Importa que los ítems estén ordenados según el comparador. No hay necesidad
;;   de verificar que el orden sea estable.

global es_indice_ordenado
es_indice_ordenado:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits o 8 bits.
	;
	; r/m64 = item_t**     inventario RDI, puntero a puntero
	; r/m64 = uint16_t*    indice	  RSI, puntero a int
	; r/m16 = uint16_t     tamanio	  RDX (DX)
	; r/m64 = comparador_t comparador (RCX)

	push rbp
    mov rbp, rsp
    sub rsp, 8       ; alinear para que cualquier call sea seguro
	
	XOR R15, R15 ; Lo usamos como contador
	
	MOV RBX, [RDI] ;Puntero al primer PUNTERO de item
	MOV R12, RCX
	MOV R13W, DX
	SUB R13W, 1
	MOV R14, RSI

	.loop:
		XOR RAX, RAX
		MOV AX, [R14] ;[RSI] = indice[i]
		XOR R9, R9
		MOV R9W, 32
		MUL R9W 	  ;AX = indice[i]*28
		ADD RAX, RBX
		MOV RDI, RAX ; R9 = *inventario[indice[i]]

		ADD R14, 2
		XOR RAX, RAX
		MOV AX, [R14] ;[RSI] = indice[i]
		XOR R9, R9
		MOV R9W, 32
		MUL R9W 	  ;AX = indice[i]*28
		ADD RAX, RBX
		MOV RSI, RAX ;item2
		
		;Llamo al comparador (RCX) pasandole los item1 (RDI) e item2 (RSI)
		sub rsp, 8 
		call R12 ;Con esto AL = 0x00 RDI > RSI y AL = 0x00 Si RDI <= RSI
		add rsp, 8

		test AL, AL ;Si RAL es false
		JE .falso

		INC R15W ;Sumo 1 al contador
		CMP R15W, R13W
		JE .verdadero

		JMP .loop


	.falso:
		XOR RAX, RAX
		MOV AL, 0
		add rsp, 8
    	pop rbp
		ret

	.verdadero:
		XOR RAX, RAX
		MOV AL, 1
		add rsp, 8
    	pop rbp
		ret

;; Dado un inventario y una vista, crear un nuevo inventario que mantenga el
;; orden descrito por la misma.

;; La memoria a solicitar para el nuevo inventario debe poder ser liberada
;; utilizando `free(ptr)`.

;; item_t** indice_a_inventario(item_t** inventario, uint16_t* indice, uint16_t tamanio);

;; Donde:
;; - `inventario` un array de punteros a ítems que representa el inventario a
;;   procesar.
;; - `indice` es el arreglo de índices en el inventario que representa la vista
;;   que vamos a usar para reorganizar el inventario.
;; - `tamanio` es el tamaño del inventario.
;; 
;; Tenga en consideración:
;; - Tanto los elementos de `inventario` como los del resultado son punteros a
;;   `ítems`. Se pide *copiar* estos punteros, **no se deben crear ni clonar
;;   ítems**

global indice_a_inventario
indice_a_inventario:
	; Te recomendamos llenar una tablita acá con cada parámetro y su
	; ubicación según la convención de llamada. Prestá atención a qué
	; valores son de 64 bits y qué valores son de 32 bits o 8 bits.
	;
	; r/m64 = item_t**  inventario RDI
	; r/m64 = uint16_t* indice	   RSI
	; r/m16 = uint16_t  tamanio	   RDX (DX)

	PUSH rbp
	MOV RBP, RSP

	MOV RBX, RDI
	MOV R12, RSI
	XOR R15, R15
	MOV R15W, DX 

	movzx rsi, dx
	imul rdi, rsi, 8     ; rdi = dx * 8
	call malloc
	MOV R13, RAX ;R13 es el puntero del nuevo inventario
	MOV R14, RAX ;R14 tambien, pero lo vamos a dejar en el 1er puntero para retornar

	XOR R10, R10

	.loop:
		mov R8, [RBX] ; R8 es el puntero al 1er item
		MOV RAX, 32
		XOR R9, R9
		MOV R9W, [R12]
		MUL R9W
		ADD R8, RAX

		MOV [R13], R8
		INC R10W
		ADD R13, 8 ;Movemos r13 8 bytes para el proximo puntero
		ADD R12, 2

		CMP r10w, R15W
		je .fin

		jmp .loop

	.fin:
		MOV RAX, R14
		POP RBP
		ret




	 

