	.file	"generador.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"Uso: %s <num_pasos>\n"
.LC3:
	.string	"Promedio: %f\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC5:
	.string	"Tiempo de ejecucion: %f milisegundos\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	cmpl	$1, %edi
	jle	.L12
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movq	%rax, %rbx
	call	omp_get_wtime@PLT
	movsd	%xmm0, 8(%rsp)
	testq	%rbx, %rbx
	jle	.L8
	movq	%rbx, %rdi
	movl	$3037000493, %ecx
	pxor	%xmm1, %xmm1
	movabsq	$2862933555777941757, %rsi
	imulq	%rsi, %rdi
	movsd	.LC2(%rip), %xmm2
	addq	%rcx, %rdi
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L13:
	pxor	%xmm0, %xmm0
	addq	%rsi, %rcx
	cvtsi2sdq	%rdx, %xmm0
	mulsd	%xmm2, %xmm0
	addsd	%xmm0, %xmm1
	cmpq	%rcx, %rdi
	je	.L4
.L7:
	movq	%rcx, %rax
	shrq	$33, %rax
	xorq	%rcx, %rax
	imulq	%rsi, %rax
	movq	%rax, %rdx
	shrq	$33, %rdx
	xorq	%rax, %rdx
	jns	.L13
	movq	%rdx, %rax
	andl	$1, %edx
	pxor	%xmm0, %xmm0
	addq	%rsi, %rcx
	shrq	%rax
	orq	%rdx, %rax
	cvtsi2sdq	%rax, %xmm0
	addsd	%xmm0, %xmm0
	mulsd	%xmm2, %xmm0
	addsd	%xmm0, %xmm1
	cmpq	%rcx, %rdi
	jne	.L7
.L4:
	movsd	%xmm1, 24(%rsp)
	call	omp_get_wtime@PLT
	movsd	24(%rsp), %xmm1
	movl	$2, %edi
	leaq	.LC3(%rip), %rsi
	movsd	%xmm0, 16(%rsp)
	pxor	%xmm0, %xmm0
	movl	$1, %eax
	cvtsi2sdq	%rbx, %xmm0
	divsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm0
	call	__printf_chk@PLT
	movsd	16(%rsp), %xmm2
	subsd	8(%rsp), %xmm2
	leaq	.LC5(%rip), %rsi
	mulsd	.LC4(%rip), %xmm2
	movl	$2, %edi
	movl	$1, %eax
	movapd	%xmm2, %xmm0
	call	__printf_chk@PLT
	xorl	%eax, %eax
.L1:
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L12:
	.cfi_restore_state
	movq	(%rsi), %rdx
	movl	$2, %edi
	xorl	%eax, %eax
	leaq	.LC1(%rip), %rsi
	call	__printf_chk@PLT
	movl	$1, %eax
	jmp	.L1
.L8:
	pxor	%xmm1, %xmm1
	jmp	.L4
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC2:
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
