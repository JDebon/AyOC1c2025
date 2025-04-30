#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "../test-utils.h"
#include "Memoria.h"

int main() {
	char coso[] = "";
	char coso2[] = "Orga 2!";
	char *res = strCmp(&coso, &coso2);
	return 0;
}
