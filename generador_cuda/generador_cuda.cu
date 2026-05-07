#include <stdio.h>
#include <stdlib.h>
#include <cuda_runtime.h>

#define CUDA_CHECK(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, const char *file, int line, bool abort=true) {
   if (code != cudaSuccess) {
      fprintf(stderr,"GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
      if (abort) exit(code);
   }
}

// --- KERNEL: Ejecución en paralelo masivo ---
__global__ void generadorGPU(long numSteps, double* d_sum) {
    // Cálculo del índice global del hilo
    long i = blockIdx.x * (long)blockDim.x + threadIdx.x;

    if (i < numSteps) {
        // Algoritmo basado en contador
        unsigned long long x = (i * 2862933555777941757ULL) + 3037000493ULL;
        x ^= x >> 33;
        x *= 2862933555777941757ULL;
        x ^= x >> 33;

        double valor = (double)x / 18446744073709551615.0;

        // Reducción atómica: garantiza que no haya condiciones de carrera
        atomicAdd(d_sum, valor);
    }
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf("Uso: %s <num_pasos>\n", argv[0]);
        return 1;
    }

    long numSteps = atol(argv[1]);
    double h_sum = 0.0;
    double *d_sum;

    // 1. Preparación del dispositivo
    CUDA_CHECK(cudaMalloc((void**)&d_sum, sizeof(double)));
    CUDA_CHECK(cudaMemcpy(d_sum, &h_sum, sizeof(double), cudaMemcpyHostToDevice));

    // 2. Configuración de la Grid (DLP)
    // Usamos 256 hilos por bloque, estándar para la mayoría de GPUs NVIDIA
    int threadsPerBlock = 256;
    long blocksPerGrid = (numSteps + threadsPerBlock - 1) / threadsPerBlock;

    // 3. Medición de tiempo con Eventos de CUDA
    cudaEvent_t start, stop;
    CUDA_CHECK(cudaEventCreate(&start));
    CUDA_CHECK(cudaEventCreate(&stop));
    
    CUDA_CHECK(cudaEventRecord(start));

    // Lanzamiento del Kernel
    generadorGPU<<<blocksPerGrid, threadsPerBlock>>>(numSteps, d_sum);

    CUDA_CHECK(cudaEventRecord(stop));
    CUDA_CHECK(cudaEventSynchronize(stop));

    float ms = 0;
    CUDA_CHECK(cudaEventElapsedTime(&ms, start, stop));

    // 4. Recuperación de resultados
    CUDA_CHECK(cudaMemcpy(&h_sum, d_sum, sizeof(double), cudaMemcpyDeviceToHost));

    // 5. Presentación de resultados finales 
    printf("--- Resultados CUDA ---\n");
    printf("Pasos: %ld\n", numSteps);
    printf("Promedio: %f\n", h_sum / numSteps);
    printf("Tiempo GPU: %f milisegundos\n", ms);

    // Limpieza
    cudaFree(d_sum);
    cudaEventDestroy(start);
    cudaEventDestroy(stop);

    return 0;
}