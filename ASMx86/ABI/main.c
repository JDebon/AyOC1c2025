#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "ABI.h"

int main() {
	/* Acá pueden realizar sus propias pruebas */
	//alternate_sum_8(2, 2, 3, 3, 4, 4, 5, 5);
	
	double* dir = malloc(8);
	//product_2_f(dir, 2,3);
	//printf("RESULTADO: %f\n", *dir);

	product_9_f(dir,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19);
	
	free(dir);

	return 0;
}
