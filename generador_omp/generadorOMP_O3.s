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
	vxorpd	%xmm1, %xmm1, %xmm1
	addq	%rcx, %rdx
	addq	%rdx, %rax
	cmpq	%rax, %rdx
	jge	.L3
	movabsq	$2862933555777941757, %rdi
	movl	$3037000493, %ecx
	vmovsd	.LC1(%rip), %xmm2
	vxorps	%xmm3, %xmm3, %xmm3
	imulq	%rdi, %rdx
	imulq	%rdi, %rax
	addq	%rcx, %rdx
	addq	%rax, %rcx
	jmp	.L6
	.p2align 4,,10
	.p2align 3
.L16:
	vcvtsi2sdq	%rax, %xmm3, %xmm0
	addq	%rdi, %rdx
	vmulsd	%xmm2, %xmm0, %xmm0
	vaddsd	%xmm0, %xmm1, %xmm1
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
	jns	.L16
	movq	%rax, %rsi
	andl	$1, %eax
	addq	%rdi, %rdx
	shrq	%rsi
	orq	%rax, %rsi
	vcvtsi2sdq	%rsi, %xmm3, %xmm0
	vaddsd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm2, %xmm0, %xmm0
	vaddsd	%xmm0, %xmm1, %xmm1
	cmpq	%rdx, %rcx
	jne	.L6
.L3:
	movq	8(%rbx), %rdx
	leaq	8(%rbx), %rcx
.L7:
	vmovq	%rdx, %xmm5
	movq	%rdx, %rax
	vaddsd	%xmm5, %xmm1, %xmm4
	vmovq	%xmm4, %rsi
	lock cmpxchgq	%rsi, (%rcx)
	jne	.L17
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
.L17:
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
	jle	.L23
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
	vmovsd	%xmm0, 8(%rsp)
	movq	$0x000000000, 40(%rsp)
	movq	%rbx, 32(%rsp)
	call	GOMP_parallel@PLT
	vmovsd	40(%rsp), %xmm3
	vmovsd	%xmm3, 24(%rsp)
	call	omp_get_wtime@PLT
	vxorps	%xmm2, %xmm2, %xmm2
	vmovsd	24(%rsp), %xmm3
	leaq	.LC3(%rip), %rsi
	vcvtsi2sdq	%rbx, %xmm2, %xmm2
	vmovsd	%xmm0, 16(%rsp)
	movl	$2, %edi
	movl	$1, %eax
	vdivsd	%xmm2, %xmm3, %xmm0
	call	__printf_chk@PLT
	vmovsd	16(%rsp), %xmm1
	vsubsd	8(%rsp), %xmm1, %xmm0
	leaq	.LC5(%rip), %rsi
	vmulsd	.LC4(%rip), %xmm0, %xmm0
	movl	$2, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	xorl	%eax, %eax
.L18:
	movq	56(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L24
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L23:
	.cfi_restore_state
	movq	(%rsi), %rdx
	movl	$2, %edi
	leaq	.LC2(%rip), %rsi
	call	__printf_chk@PLT
	movl	$1, %eax
	jmp	.L18
.L24:
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
