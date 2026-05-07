	.file	"generador_omp.c"
	.text
	.p2align 4
	.type	main._omp_fn.0, @function
main._omp_fn.0:
.LFB40:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	omp_get_num_threads@PLT
	movl	%eax, %ebp
	call	omp_get_thread_num@PLT
	movslq	%ebp, %rsi
	movslq	%eax, %rcx
	movq	(%rbx), %rax
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
	movabsq	$2862933555777941757, %rdi
	movl	$3037000493, %ecx
	movsd	.LC1(%rip), %xmm2
	imulq	%rdi, %rdx
	imulq	%rdi, %rax
	addq	%rcx, %rdx
	addq	%rax, %rcx
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L15:
	pxor	%xmm0, %xmm0
	addq	%rdi, %rdx
	cvtsi2sdq	%rax, %xmm0
	mulsd	%xmm2, %xmm0
	addsd	%xmm0, %xmm1
	cmpq	%rdx, %rcx
	je	.L3
.L6:
	movq	%rdx, %rax
	shrq	$33, %rax
	xorq	%rdx, %rax
	imulq	%rdi, %rax
	movq	%rax, %rsi
	shrq	$33, %rsi
	xorq	%rsi, %rax
	jns	.L15
	movq	%rax, %rsi
	andl	$1, %eax
	pxor	%xmm0, %xmm0
	addq	%rdi, %rdx
	shrq	%rsi
	orq	%rax, %rsi
	cvtsi2sdq	%rsi, %xmm0
	addsd	%xmm0, %xmm0
	mulsd	%xmm2, %xmm0
	addsd	%xmm0, %xmm1
	cmpq	%rdx, %rcx
	jne	.L6
.L3:
	movq	8(%rbx), %rdx
	leaq	8(%rbx), %rcx
.L7:
	movq	%rdx, %xmm3
	movq	%rdx, %rax
	addsd	%xmm1, %xmm3
	movq	%xmm3, %rsi
	lock cmpxchgq	%rsi, (%rcx)
	jne	.L16
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
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
	subq	$64, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L22
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movq	%rax, %rbx
	call	omp_get_wtime@PLT
	xorl	%ecx, %ecx
	xorl	%edx, %edx
	leaq	32(%rsp), %rsi
	leaq	main._omp_fn.0(%rip), %rdi
	movsd	%xmm0, 8(%rsp)
	movq	$0x000000000, 40(%rsp)
	movq	%rbx, 32(%rsp)
	call	GOMP_parallel@PLT
	movsd	40(%rsp), %xmm2
	movsd	%xmm2, 24(%rsp)
	call	omp_get_wtime@PLT
	movsd	24(%rsp), %xmm2
	movl	$2, %edi
	leaq	.LC3(%rip), %rsi
	movsd	%xmm0, 16(%rsp)
	pxor	%xmm0, %xmm0
	movl	$1, %eax
	cvtsi2sdq	%rbx, %xmm0
	divsd	%xmm0, %xmm2
	movapd	%xmm2, %xmm0
	call	__printf_chk@PLT
	movsd	16(%rsp), %xmm1
	subsd	8(%rsp), %xmm1
	leaq	.LC5(%rip), %rsi
	mulsd	.LC4(%rip), %xmm1
	movl	$2, %edi
	movl	$1, %eax
	movapd	%xmm1, %xmm0
	call	__printf_chk@PLT
	xorl	%eax, %eax
.L17:
	movq	56(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L23
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L22:
	.cfi_restore_state
	movq	(%rsi), %rdx
	movl	$2, %edi
	leaq	.LC2(%rip), %rsi
	call	__printf_chk@PLT
	movl	$1, %eax
	jmp	.L17
.L23:
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
