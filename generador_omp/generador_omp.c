#include <stdio.h>
#include <stdlib.h>
#include <omp.h> 

int main(int argc, char* argv[]) {
    long i;
    double sum = 0.0;
    double inicio, fin, tiempo;

    if (argc < 2) {
        printf("Uso: %s <num_pasos>\n", argv[0]);
        return 1;
    }

    long numSteps = atol(argv[1]);

    // --- Inicio de la parte a medir ---
    inicio = omp_get_wtime();

    // Paralelización del bucle con reducción para evitar condiciones de carrera
    #pragma omp parallel for reduction(+:sum)
    for (i = 0; i < numSteps; ++i) {
        unsigned long long x = (i * 2862933555777941757ULL) + 3037000493ULL;
        x ^= x >> 33;
        x *= 2862933555777941757ULL;
        x ^= x >> 33;

        sum += (double)x / 18446744073709551615.0;
    }

    fin = omp_get_wtime();
    // --- Fin de la medición ---

    tiempo = fin - inicio;

    printf("Promedio: %f\n", sum / numSteps);
    printf("Tiempo de ejecucion: %f milisegundos\n", tiempo * 1000);

    return 0;
}