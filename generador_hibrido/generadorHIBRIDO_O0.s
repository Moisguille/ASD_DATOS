	.file	"generador_hibrido.c"
	.text
	.section	.rodata
.LC1:
	.string	"Uso: %s <num_pasos>\n"
.LC2:
	.string	"Promedio total: %f\n"
.LC4:
	.string	"Tiempo total h\303\255brido: %f ms\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	addq	$-128, %rsp
	movl	%edi, -116(%rbp)
	movq	%rsi, -128(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -96(%rbp)
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -88(%rbp)
	leaq	-100(%rbp), %rdx
	leaq	-128(%rbp), %rsi
	leaq	-116(%rbp), %rax
	movq	%rdx, %rcx
	movl	$1, %edx
	movq	%rax, %rdi
	call	MPI_Init_thread@PLT
	leaq	-108(%rbp), %rax
	movq	%rax, %rsi
	leaq	ompi_mpi_comm_world(%rip), %rax
	movq	%rax, %rdi
	call	MPI_Comm_rank@PLT
	leaq	-104(%rbp), %rax
	movq	%rax, %rsi
	leaq	ompi_mpi_comm_world(%rip), %rax
	movq	%rax, %rdi
	call	MPI_Comm_size@PLT
	movl	-116(%rbp), %eax
	cmpl	$1, %eax
	jg	.L2
	movl	-108(%rbp), %eax
	testl	%eax, %eax
	jne	.L3
	movq	-128(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L3:
	call	MPI_Finalize@PLT
	movl	$1, %eax
	jmp	.L8
.L2:
	movq	-128(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atol@PLT
	movq	%rax, -80(%rbp)
	movl	-104(%rbp), %eax
	movslq	%eax, %rcx
	movq	-80(%rbp), %rax
	cqto
	idivq	%rcx
	movq	%rax, -72(%rbp)
	movl	-108(%rbp), %eax
	cltq
	movq	-72(%rbp), %rdx
	imulq	%rdx, %rax
	movq	%rax, -64(%rbp)
	movl	-104(%rbp), %eax
	leal	-1(%rax), %edx
	movl	-108(%rbp), %eax
	cmpl	%eax, %edx
	je	.L5
	movq	-64(%rbp), %rdx
	movq	-72(%rbp), %rax
	addq	%rdx, %rax
	jmp	.L6
.L5:
	movq	-80(%rbp), %rax
.L6:
	movq	%rax, -56(%rbp)
	leaq	ompi_mpi_comm_world(%rip), %rax
	movq	%rax, %rdi
	call	MPI_Barrier@PLT
	call	MPI_Wtime@PLT
	movq	%xmm0, %rax
	movq	%rax, -48(%rbp)
	movsd	-96(%rbp), %xmm0
	movsd	%xmm0, -16(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-64(%rbp), %rax
	movq	%rax, -32(%rbp)
	leaq	-32(%rbp), %rax
	movl	$0, %ecx
	movl	$0, %edx
	movq	%rax, %rsi
	leaq	main._omp_fn.0(%rip), %rax
	movq	%rax, %rdi
	call	GOMP_parallel@PLT
	movsd	-16(%rbp), %xmm0
	movsd	%xmm0, -96(%rbp)
	leaq	-88(%rbp), %rsi
	leaq	-96(%rbp), %rax
	subq	$8, %rsp
	leaq	ompi_mpi_comm_world(%rip), %rdx
	pushq	%rdx
	movl	$0, %r9d
	leaq	ompi_mpi_op_sum(%rip), %r8
	leaq	ompi_mpi_double(%rip), %rdx
	movq	%rdx, %rcx
	movl	$1, %edx
	movq	%rax, %rdi
	call	MPI_Reduce@PLT
	addq	$16, %rsp
	call	MPI_Wtime@PLT
	movq	%xmm0, %rax
	movq	%rax, -40(%rbp)
	movl	-108(%rbp), %eax
	testl	%eax, %eax
	jne	.L7
	movsd	-88(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sdq	-80(%rbp), %xmm1
	divsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movsd	-40(%rbp), %xmm0
	movapd	%xmm0, %xmm1
	subsd	-48(%rbp), %xmm1
	movsd	.LC3(%rip), %xmm0
	mulsd	%xmm0, %xmm1
	movq	%xmm1, %rax
	movq	%rax, %xmm0
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
.L7:
	call	MPI_Finalize@PLT
	movl	$0, %eax
.L8:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L9
	call	__stack_chk_fail@PLT
.L9:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.type	main._omp_fn.0, @function
main._omp_fn.0:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$72, %rsp
	.cfi_offset 13, -24
	.cfi_offset 12, -32
	.cfi_offset 3, -40
	movq	%rdi, -88(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -40(%rbp)
	xorl	%eax, %eax
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -80(%rbp)
	movq	-88(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -64(%rbp)
	movq	-88(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rbx
	movq	-64(%rbp), %r13
	call	omp_get_num_threads@PLT
	movslq	%eax, %r12
	call	omp_get_thread_num@PLT
	movslq	%eax, %rdi
	movq	%r13, %rsi
	subq	%rbx, %rsi
	movq	%rsi, %rax
	cqto
	idivq	%r12
	movq	%rax, %rcx
	movq	%rsi, %rax
	cqto
	idivq	%r12
	movq	%rdx, %rax
	cmpq	%rax, %rdi
	jl	.L11
.L17:
	imulq	%rcx, %rdi
	movq	%rdi, %rdx
	addq	%rdx, %rax
	leaq	(%rax,%rcx), %rdx
	cmpq	%rdx, %rax
	jge	.L12
	addq	%rbx, %rax
	movq	%rax, -72(%rbp)
	leaq	(%rdx,%rbx), %rcx
.L15:
	movq	-72(%rbp), %rax
	movabsq	$2862933555777941757, %rdx
	imulq	%rdx, %rax
	movl	$3037000493, %edx
	addq	%rdx, %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	shrq	$33, %rax
	xorq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movabsq	$2862933555777941757, %rdx
	imulq	%rdx, %rax
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	shrq	$33, %rax
	xorq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	testq	%rax, %rax
	js	.L13
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	jmp	.L14
.L13:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rdx, %xmm0
	addsd	%xmm0, %xmm0
.L14:
	movsd	.LC5(%rip), %xmm2
	movapd	%xmm0, %xmm1
	divsd	%xmm2, %xmm1
	movsd	-80(%rbp), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -80(%rbp)
	addq	$1, -72(%rbp)
	cmpq	%rcx, -72(%rbp)
	jl	.L15
.L12:
	movsd	-80(%rbp), %xmm0
	movq	-88(%rbp), %rax
	leaq	16(%rax), %rdx
	movq	(%rdx), %rcx
.L16:
	movq	%rcx, %xmm1
	addsd	%xmm0, %xmm1
	movq	%xmm1, %rsi
	movq	%rcx, %rax
	lock cmpxchgq	%rsi, (%rdx)
	movq	%rcx, %rsi
	movq	%rax, %rcx
	cmpq	%rsi, %rax
	jne	.L16
	jmp	.L19
.L11:
	movl	$0, %eax
	addq	$1, %rcx
	jmp	.L17
.L19:
	movq	-40(%rbp), %rax
	subq	%fs:40, %rax
	je	.L18
	call	__stack_chk_fail@PLT
.L18:
	addq	$72, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	main._omp_fn.0, .-main._omp_fn.0
	.section	.rodata
	.align 8
.LC3:
	.long	0
	.long	1083129856
	.align 8
.LC5:
	.long	0
	.long	1139802112
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
