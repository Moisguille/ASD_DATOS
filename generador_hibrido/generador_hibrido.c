#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include <omp.h>

int main(int argc, char* argv[]) {
    long i;
    double local_sum = 0.0, total_sum = 0.0;
    double inicio, fin;
    int rank, size, provided;

    // Inicialización de MPI con soporte para hilos
    MPI_Init_thread(&argc, &argv, MPI_THREAD_FUNNELED, &provided);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    if (argc < 2) {
        if (rank == 0) printf("Uso: %s <num_pasos>\n", argv[0]);
        MPI_Finalize();
        return 1;
    }

    long numSteps = atol(argv[1]);
    
    // División del trabajo entre procesos MPI
    long steps_per_proc = numSteps / size;
    long start_idx = rank * steps_per_proc;
    long end_idx = (rank == size - 1) ? numSteps : start_idx + steps_per_proc;

    MPI_Barrier(MPI_COMM_WORLD);
    inicio = MPI_Wtime();

    // --- NIVEL OPENMP (Intra-nodo) ---
    #pragma omp parallel for reduction(+:local_sum)
    for (i = start_idx; i < end_idx; ++i) {
        unsigned long long x = (i * 2862933555777941757ULL) + 3037000493ULL;
        x ^= x >> 33;
        x *= 2862933555777941757ULL;
        x ^= x >> 33;
        local_sum += (double)x / 18446744073709551615.0;
    }

    // --- NIVEL MPI (Inter-nodo) ---
    MPI_Reduce(&local_sum, &total_sum, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);

    fin = MPI_Wtime();

    if (rank == 0) {
        printf("Promedio total: %f\n", total_sum / numSteps);
        printf("Tiempo total híbrido: %f ms\n", (fin - inicio) * 1000);
    }

    MPI_Finalize();
    return 0;
}