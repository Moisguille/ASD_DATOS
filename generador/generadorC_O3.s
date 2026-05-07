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
	testq	%rbx, %rbx
	vxorps	%xmm2, %xmm2, %xmm2
	vmovsd	%xmm0, 8(%rsp)
	jle	.L8
	movq	%rbx, %rdi
	movl	$3037000493, %ecx
	vxorpd	%xmm1, %xmm1, %xmm1
	movabsq	$2862933555777941757, %rsi
	imulq	%rsi, %rdi
	vmovsd	.LC2(%rip), %xmm3
	addq	%rcx, %rdi
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L13:
	vcvtsi2sdq	%rdx, %xmm2, %xmm0
	addq	%rsi, %rcx
	vmulsd	%xmm3, %xmm0, %xmm0
	vaddsd	%xmm0, %xmm1, %xmm1
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
	addq	%rsi, %rcx
	shrq	%rax
	orq	%rdx, %rax
	vcvtsi2sdq	%rax, %xmm2, %xmm0
	vaddsd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm3, %xmm0, %xmm0
	vaddsd	%xmm0, %xmm1, %xmm1
	cmpq	%rcx, %rdi
	jne	.L7
.L4:
	vmovsd	%xmm1, 24(%rsp)
	call	omp_get_wtime@PLT
	vxorps	%xmm2, %xmm2, %xmm2
	vmovsd	24(%rsp), %xmm1
	leaq	.LC3(%rip), %rsi
	vcvtsi2sdq	%rbx, %xmm2, %xmm2
	vmovsd	%xmm0, 16(%rsp)
	movl	$2, %edi
	movl	$1, %eax
	vdivsd	%xmm2, %xmm1, %xmm0
	call	__printf_chk@PLT
	vmovsd	16(%rsp), %xmm3
	vsubsd	8(%rsp), %xmm3, %xmm0
	leaq	.LC5(%rip), %rsi
	vmulsd	.LC4(%rip), %xmm0, %xmm0
	movl	$2, %edi
	movl	$1, %eax
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
	vxorpd	%xmm1, %xmm1, %xmm1
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
