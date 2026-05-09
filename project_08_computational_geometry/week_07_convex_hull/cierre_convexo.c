#include <stdio.h>

struct Punto {
    int x;
    int y;
};

// Función para orientación
// Calcula la orientación de tres puntos
// Retorna:
// 0 -> colineales
// 1 -> horario
// 2 -> antihorario
int orientacion(struct Punto p, struct Punto q, struct Punto r) {
    int val = (q.y - p.y) * (r.x - q.x) -
              (q.x - p.x) * (r.y - q.y);

    if (val == 0) return 0;
    return (val > 0) ? 1 : 2;
}

// Función cierre convexo
// Implementa el algoritmo Gift Wrapping (Marcha de Jarvis)
// Encuentra los puntos que forman el cierre convexo
void cierreConvexo(struct Punto puntos[], int n) {
    if (n < 3) return;

    int l = 0;
    for (int i = 1; i < n; i++)
        if (puntos[i].x < puntos[l].x)
            l = i;

    int p = l, q;

    printf("Puntos del cierre convexo:\n");

    do {
        printf("(%d, %d)\n", puntos[p].x, puntos[p].y);

        q = (p + 1) % n;

        for (int i = 0; i < n; i++) {
            if (orientacion(puntos[p], puntos[i], puntos[q]) == 2)
                q = i;
        }

        p = q;

    } while (p != l);
}

// FUNCIÓN PRINCIPAL 
// Función principal:
// - Define los puntos de prueba
// - Muestra los datos ingresados
// - Llama al algoritmo de cierre convexo
int main() {

    printf("=== CALCULO DE CIERRE CONVEXO ===\n\n");

    struct Punto puntos[] = {
        {0, 3}, {2, 2}, {1, 1}, {2, 1},
        {3, 0}, {0, 0}, {3, 3}, {2, 4}
    };

    int n = 8;

    printf("Puntos ingresados:\n");
    for (int i = 0; i < n; i++) {
        printf("(%d, %d)\n", puntos[i].x, puntos[i].y);
    }

    printf("\nCalculando cierre convexo...\n\n");

    cierreConvexo(puntos, n);

    return 0;

}