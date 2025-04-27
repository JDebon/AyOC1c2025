#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "Estructuras.h"

int main() {
	packed_nodo_t nodo1 = {NULL, 1, NULL, 3};
	packed_nodo_t nodo2 = {&nodo1, 1, NULL, 5};
	packed_lista_t lista = {&nodo2};


	cantidad_total_de_elementos_packed(&lista);

	return 0;
}
