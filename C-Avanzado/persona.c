# include <stdio.h>
# include <stdint.h>
# include <stdlib.h>


struct Persona
{
    int edad;
    char* nombre;
};

struct Persona* crearPersona(uint8_t edad, char* nombre) {
    struct Persona *p = malloc(sizeof(uint8_t) + sizeof(*nombre));
    p->edad = edad;
    p->nombre = nombre;
    return p;
}

void eliminarPersona(struct Persona* p) {
    free(p);
}


int main() {
    struct Persona* p = crearPersona(23, "matias");
    printf("%s - %d\n", p->nombre, p->edad);
    eliminarPersona(p);
}
