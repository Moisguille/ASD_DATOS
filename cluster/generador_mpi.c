#include <stdio.h>
#include <stdlib.h>
#include <mpi.h> 

int main(int argc, char* argv[]) {
    long i;
    double local_sum = 0.0, total_sum = 0.0;
    double inicio, fin, tiempo;
    int rank, size;

    MPI_Init(&argc, &argv); // Inicializa el entorno MPI
    MPI_Comm_rank(MPI_COMM_WORLD, &rank); // Identificador del proceso 
    MPI_Comm_size(MPI_COMM_WORLD, &size); // Número total de procesos

    if (argc < 2) {
        if (rank == 0) printf("Uso: %s <num_pasos>\n", argv[0]);
        MPI_Finalize();
        return 1;
    }

    long numSteps = atol(argv[1]);
    
    // División del trabajo: cada proceso hace una parte
    long steps_per_proc = numSteps / size;
    long start_idx = rank * steps_per_proc;
    long end_idx = (rank == size - 1) ? numSteps : start_idx + steps_per_proc;

    // Sincronización y medida de tiempo solo en el maestro
    MPI_Barrier(MPI_COMM_WORLD);
    inicio = MPI_Wtime();

    for (i = start_idx; i < end_idx; ++i) {
        unsigned long long x = (i * 2862933555777941757ULL) + 3037000493ULL;
        x ^= x >> 33;
        x *= 2862933555777941757ULL;
        x ^= x >> 33;
        local_sum += (double)x / 18446744073709551615.0;
    }

    // Reducción: el proceso 0 recolecta y suma los resultados de todos
    MPI_Reduce(&local_sum, &total_sum, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);

    fin = MPI_Wtime();

    if (rank == 0) {
        tiempo = fin - inicio;
        printf("Promedio: %f\n", total_sum / numSteps);
        printf("Tiempo de ejecucion (MPI): %f milisegundos\n", tiempo * 1000);
    }

    MPI_Finalize(); // Finaliza el entorno MPI
    return 0;
}