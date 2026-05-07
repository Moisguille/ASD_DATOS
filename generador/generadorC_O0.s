	.file	"generador.c"
	.text
	.section	.rodata
.LC1:
	.string	"Uso: %s <num_pasos>\n"
.LC3:
	.string	"Promedio: %f\n"
	.align 8
.LC5:
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
	subq	$80, %rsp
	movl	%edi, -68(%rbp)
	movq	%rsi, -80(%rbp)
	pxor	%xmm0, %xmm0
	movsd	%xmm0, -48(%rbp)
	cmpl	$1, -68(%rbp)
	jg	.L2
	movq	-80(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$1, %eax
	jmp	.L3
.L2:
	movq	-80(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atol@PLT
	movq	%rax, -40(%rbp)
	call	omp_get_wtime@PLT
	movq	%xmm0, %rax
	movq	%rax, -32(%rbp)
	movq	$0, -56(%rbp)
	jmp	.L4
.L7:
	movq	-56(%rbp), %rax
	movabsq	$2862933555777941757, %rdx
	imulq	%rdx, %rax
	movl	$3037000493, %edx
	addq	%rdx, %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	shrq	$33, %rax
	xorq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movabsq	$2862933555777941757, %rdx
	imulq	%rdx, %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	shrq	$33, %rax
	xorq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	testq	%rax, %rax
	js	.L5
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	jmp	.L6
.L5:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rdx, %xmm0
	addsd	%xmm0, %xmm0
.L6:
	movsd	.LC2(%rip), %xmm1
	divsd	%xmm1, %xmm0
	movsd	-48(%rbp), %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -48(%rbp)
	addq	$1, -56(%rbp)
.L4:
	movq	-56(%rbp), %rax
	cmpq	-40(%rbp), %rax
	jl	.L7
	call	omp_get_wtime@PLT
	movq	%xmm0, %rax
	movq	%rax, -24(%rbp)
	movsd	-24(%rbp), %xmm0
	subsd	-32(%rbp), %xmm0
	movsd	%xmm0, -16(%rbp)
	pxor	%xmm1, %xmm1
	cvtsi2sdq	-40(%rbp), %xmm1
	movsd	-48(%rbp), %xmm0
	divsd	%xmm1, %xmm0
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movsd	-16(%rbp), %xmm1
	movsd	.LC4(%rip), %xmm0
	mulsd	%xmm0, %xmm1
	movq	%xmm1, %rax
	movq	%rax, %xmm0
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$0, %eax
.L3:
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
