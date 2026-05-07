	.file	"generador_mpi.c"
	.text
	.section	.rodata
.LC1:
	.string	"Uso: %s <num_pasos>\n"
.LC3:
	.string	"Promedio: %f\n"
	.align 8
.LC5:
	.string	"Tiempo de ejecucion (MPI): %f milisegundos\n"
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
	leaq	-128(%rbp), %rdx
	leaq	-116(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	MPI_Init@PLT
	leaq	-104(%rbp), %rax
	movq	%rax, %rsi
	leaq	ompi_mpi_comm_world(%rip), %rax
	movq	%rax, %rdi
	call	MPI_Comm_rank@PLT
	leaq	-100(%rbp), %rax
	movq	%rax, %rsi
	leaq	ompi_mpi_comm_world(%rip), %rax
	movq	%rax, %rdi
	call	MPI_Comm_size@PLT
	movl	-116(%rbp), %eax
	cmpl	$1, %eax
	jg	.L2
	movl	-104(%rbp), %eax
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
	jmp	.L12
.L2:
	movq	-128(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atol@PLT
	movq	%rax, -72(%rbp)
	movl	-100(%rbp), %eax
	movslq	%eax, %rcx
	movq	-72(%rbp), %rax
	cqto
	idivq	%rcx
	movq	%rax, -64(%rbp)
	movl	-104(%rbp), %eax
	cltq
	movq	-64(%rbp), %rdx
	imulq	%rdx, %rax
	movq	%rax, -56(%rbp)
	movl	-100(%rbp), %eax
	leal	-1(%rax), %edx
	movl	-104(%rbp), %eax
	cmpl	%eax, %edx
	je	.L5
	movq	-56(%rbp), %rdx
	movq	-64(%rbp), %rax
	addq	%rdx, %rax
	jmp	.L6
.L5:
	movq	-72(%rbp), %rax
.L6:
	movq	%rax, -48(%rbp)
	leaq	ompi_mpi_comm_world(%rip), %rax
	movq	%rax, %rdi
	call	MPI_Barrier@PLT
	call	MPI_Wtime@PLT
	movq	%xmm0, %rax
	movq	%rax, -40(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, -80(%rbp)
	jmp	.L7
.L10:
	movq	-80(%rbp), %rax
	movabsq	$2862933555777941757, %rdx
	imulq	%rdx, %rax
	movl	$3037000493, %edx
	addq	%rdx, %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	shrq	$33, %rax
	xorq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movabsq	$2862933555777941757, %rdx
	imulq	%rdx, %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	shrq	$33, %rax
	xorq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	testq	%rax, %rax
	js	.L8
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	jmp	.L9
.L8:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rdx, %xmm0
	addsd	%xmm0, %xmm0
.L9:
	movsd	.LC2(%rip), %xmm2
	movapd	%xmm0, %xmm1
	divsd	%xmm2, %xmm1
	movsd	-96(%rbp), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -96(%rbp)
	addq	$1, -80(%rbp)
.L7:
	movq	-80(%rbp), %rax
	cmpq	-48(%rbp), %rax
	jl	.L10
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
	movq	%rax, -32(%rbp)
	movl	-104(%rbp), %eax
	testl	%eax, %eax
	jne	.L11
	movsd	-32(%rbp), %xmm0
	subsd	-40(%rbp), %xmm0
	movsd	%xmm0, -24(%rbp)
	movsd	-88(%rbp), %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sdq	-72(%rbp), %xmm1
	divsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movsd	-24(%rbp), %xmm1
	movsd	.LC4(%rip), %xmm0
	mulsd	%xmm0, %xmm1
	movq	%xmm1, %rax
	movq	%rax, %xmm0
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
.L11:
	call	MPI_Finalize@PLT
	movl	$0, %eax
.L12:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L13
	call	__stack_chk_fail@PLT
.L13:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC2:
	.long	0
	.long	1139802112
	.align 8
.LC4:
	.long	0
	.long	1083129856
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
