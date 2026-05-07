	.file	"generador_hibrido.c"
	.text
	.p2align 4
	.type	main._omp_fn.0, @function
main._omp_fn.0:
.LFB40:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	movq	(%rdi), %r12
	call	omp_get_num_threads@PLT
	movl	%eax, %ebp
	call	omp_get_thread_num@PLT
	movslq	%ebp, %rsi
	movslq	%eax, %rcx
	movq	8(%rbx), %rax
	subq	%r12, %rax
	cqto
	idivq	%rsi
	cmpq	%rdx, %rcx
	jl	.L2
.L8:
	imulq	%rax, %rcx
	pxor	%xmm1, %xmm1
	addq	%rcx, %rdx
	addq	%rdx, %rax
	cmpq	%rax, %rdx
	jge	.L3
	addq	%r12, %rdx
	movl	$3037000493, %ecx
	addq	%r12, %rax
	movabsq	$2862933555777941757, %r8
	movq	%rdx, %rsi
	movsd	.LC1(%rip), %xmm2
	imulq	%r8, %rsi
	addq	%rcx, %rsi
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L15:
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rcx, %xmm0
.L5:
	mulsd	%xmm2, %xmm0
	addq	$1, %rdx
	addq	%r8, %rsi
	addsd	%xmm0, %xmm1
	cmpq	%rdx, %rax
	jle	.L3
.L6:
	movq	%rsi, %rcx
	shrq	$33, %rcx
	xorq	%rsi, %rcx
	imulq	%r8, %rcx
	movq	%rcx, %rdi
	shrq	$33, %rdi
	xorq	%rdi, %rcx
	jns	.L15
	movq	%rcx, %rdi
	andl	$1, %ecx
	pxor	%xmm0, %xmm0
	shrq	%rdi
	orq	%rcx, %rdi
	cvtsi2sdq	%rdi, %xmm0
	addsd	%xmm0, %xmm0
	jmp	.L5
	.p2align 4,,10
	.p2align 3
.L3:
	movq	16(%rbx), %rdx
	leaq	16(%rbx), %rcx
.L7:
	movq	%rdx, %xmm3
	movq	%rdx, %rax
	addsd	%xmm1, %xmm3
	movq	%xmm3, %rsi
	lock cmpxchgq	%rsi, (%rcx)
	jne	.L16
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L2:
	.cfi_restore_state
	addq	$1, %rax
	xorl	%edx, %edx
	jmp	.L8
.L16:
	movq	%rax, %rdx
	jmp	.L7
	.cfi_endproc
.LFE40:
	.size	main._omp_fn.0, .-main._omp_fn.0
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"Uso: %s <num_pasos>\n"
.LC3:
	.string	"Promedio total: %f\n"
.LC5:
	.string	"Tiempo total h\303\255brido: %f ms\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	movl	$1, %edx
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	leaq	ompi_mpi_comm_world(%rip), %rbx
	subq	$104, %rsp
	.cfi_def_cfa_offset 144
	movl	%edi, 28(%rsp)
	leaq	44(%rsp), %rcx
	leaq	28(%rsp), %rdi
	movq	%rsi, 16(%rsp)
	leaq	16(%rsp), %rsi
	movq	%fs:40, %rax
	movq	%rax, 88(%rsp)
	xorl	%eax, %eax
	movq	$0x000000000, 48(%rsp)
	movq	$0x000000000, 56(%rsp)
	call	MPI_Init_thread@PLT
	leaq	36(%rsp), %rsi
	movq	%rbx, %rdi
	call	MPI_Comm_rank@PLT
	leaq	40(%rsp), %rsi
	movq	%rbx, %rdi
	call	MPI_Comm_size@PLT
	cmpl	$1, 28(%rsp)
	jle	.L26
	movq	16(%rsp), %rax
	movl	$10, %edx
	xorl	%esi, %esi
	movq	8(%rax), %rdi
	call	strtol@PLT
	movslq	40(%rsp), %rsi
	movslq	36(%rsp), %r12
	cqto
	movq	%rax, %rbp
	idivq	%rsi
	movq	%rsi, %rcx
	movq	%r12, %rdx
	subl	$1, %ecx
	imulq	%rax, %r12
	cmpl	%ecx, %edx
	je	.L24
	leaq	(%rax,%r12), %r13
.L21:
	movq	%rbx, %rdi
	call	MPI_Barrier@PLT
	call	MPI_Wtime@PLT
	leaq	64(%rsp), %rsi
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	movsd	%xmm0, (%rsp)
	movsd	48(%rsp), %xmm0
	leaq	main._omp_fn.0(%rip), %rdi
	movq	%r13, 72(%rsp)
	movsd	%xmm0, 80(%rsp)
	movq	%r12, 64(%rsp)
	call	GOMP_parallel@PLT
	movsd	80(%rsp), %xmm0
	leaq	56(%rsp), %rsi
	xorl	%r9d, %r9d
	leaq	48(%rsp), %rdi
	leaq	ompi_mpi_double(%rip), %rcx
	movl	$1, %edx
	movsd	%xmm0, 48(%rsp)
	leaq	ompi_mpi_op_sum(%rip), %r8
	pushq	%rax
	.cfi_def_cfa_offset 152
	pushq	%rbx
	.cfi_def_cfa_offset 160
	call	MPI_Reduce@PLT
	call	MPI_Wtime@PLT
	popq	%rdx
	.cfi_def_cfa_offset 152
	popq	%rcx
	.cfi_def_cfa_offset 144
	cmpl	$0, 36(%rsp)
	je	.L27
.L22:
	call	MPI_Finalize@PLT
	xorl	%eax, %eax
.L17:
	movq	88(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L28
	addq	$104, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L26:
	.cfi_restore_state
	cmpl	$0, 36(%rsp)
	je	.L29
.L19:
	call	MPI_Finalize@PLT
	movl	$1, %eax
	jmp	.L17
.L24:
	movq	%rbp, %r13
	jmp	.L21
.L27:
	pxor	%xmm2, %xmm2
	movsd	%xmm0, 8(%rsp)
	movsd	56(%rsp), %xmm0
	leaq	.LC3(%rip), %rsi
	cvtsi2sdq	%rbp, %xmm2
	movl	$2, %edi
	movl	$1, %eax
	divsd	%xmm2, %xmm0
	call	__printf_chk@PLT
	movsd	8(%rsp), %xmm1
	subsd	(%rsp), %xmm1
	leaq	.LC5(%rip), %rsi
	movsd	.LC4(%rip), %xmm0
	movl	$2, %edi
	movl	$1, %eax
	mulsd	%xmm1, %xmm0
	call	__printf_chk@PLT
	jmp	.L22
.L29:
	movq	16(%rsp), %rax
	leaq	.LC2(%rip), %rsi
	movl	$2, %edi
	movq	(%rax), %rdx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L19
.L28:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1005584384
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
