	.file	"generador_omp.c"
	.text
	.section	.rodata
.LC1:
	.string	"Uso: %s <num_pasos>\n"
.LC2:
	.string	"Promedio: %f\n"
	.align 8
.LC4:
	.string	"Tiempo de ejecucion: %f milisegundos\n"
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
	subq	$96, %rsp
	movl	%edi, -84(%rbp)
	movq	%rsi, -96(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -72(%rbp)
	cmpl	$1, -84(%rbp)
	jg	.L2
	movq	-96(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$1, %eax
	jmp	.L3
.L2:
	movq	-96(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atol@PLT
	movq	%rax, -64(%rbp)
	call	omp_get_wtime@PLT
	movq	%xmm0, %rax
	movq	%rax, -56(%rbp)
	movsd	-72(%rbp), %xmm0
	movsd	%xmm0, -24(%rbp)
	movq	-64(%rbp), %rax
	movq	%rax, -32(%rbp)
	leaq	-32(%rbp), %rax
	movl	$0, %ecx
	movl	$0, %edx
	movq	%rax, %rsi
	leaq	main._omp_fn.0(%rip), %rax
	movq	%rax, %rdi
	call	GOMP_parallel@PLT
	movsd	-24(%rbp), %xmm0
	movsd	%xmm0, -72(%rbp)
	call	omp_get_wtime@PLT
	movq	%xmm0, %rax
	movq	%rax, -48(%rbp)
	movsd	-48(%rbp), %xmm0
	subsd	-56(%rbp), %xmm0
	movsd	%xmm0, -40(%rbp)
	pxor	%xmm1, %xmm1
	cvtsi2sdq	-64(%rbp), %xmm1
	movsd	-72(%rbp), %xmm0
	divsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movsd	-40(%rbp), %xmm1
	movsd	.LC3(%rip), %xmm0
	mulsd	%xmm0, %xmm1
	movq	%xmm1, %rax
	movq	%rax, %xmm0
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$0, %eax
.L3:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L4
	call	__stack_chk_fail@PLT
.L4:
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
	pushq	%r12
	pushq	%rbx
	subq	$48, %rsp
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	movq	%rdi, -56(%rbp)
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -48(%rbp)
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rbx
	call	omp_get_num_threads@PLT
	movslq	%eax, %r12
	call	omp_get_thread_num@PLT
	movslq	%eax, %rsi
	movq	%rbx, %rax
	cqto
	idivq	%r12
	movq	%rax, %rcx
	movq	%rbx, %rax
	cqto
	idivq	%r12
	movq	%rdx, %rax
	cmpq	%rax, %rsi
	jl	.L6
.L12:
	imulq	%rcx, %rsi
	movq	%rsi, %rdx
	addq	%rdx, %rax
	addq	%rax, %rcx
	cmpq	%rcx, %rax
	jge	.L7
	movq	%rax, -40(%rbp)
.L10:
	movq	-40(%rbp), %rax
	movabsq	$2862933555777941757, %rdx
	imulq	%rdx, %rax
	movl	$3037000493, %edx
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	shrq	$33, %rax
	xorq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movabsq	$2862933555777941757, %rdx
	imulq	%rdx, %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	shrq	$33, %rax
	xorq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
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
	movsd	.LC5(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	-48(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -48(%rbp)
	addq	$1, -40(%rbp)
	cmpq	%rcx, -40(%rbp)
	jl	.L10
.L7:
	movq	-56(%rbp), %rax
	leaq	8(%rax), %rdx
	movq	(%rdx), %rcx
.L11:
	movq	%rcx, %xmm0
	addsd	-48(%rbp), %xmm0
	movq	%xmm0, %rsi
	movq	%rcx, %rax
	lock cmpxchgq	%rsi, (%rdx)
	movq	%rcx, %rsi
	movq	%rax, %rcx
	cmpq	%rsi, %rax
	jne	.L11
	jmp	.L13
.L6:
	movl	$0, %eax
	addq	$1, %rcx
	jmp	.L12
.L13:
	addq	$48, %rsp
	popq	%rbx
	popq	%r12
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
