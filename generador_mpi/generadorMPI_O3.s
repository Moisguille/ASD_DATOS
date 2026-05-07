	.file	"generador_mpi.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"Uso: %s <num_pasos>\n"
.LC3:
	.string	"Promedio: %f\n"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC5:
	.string	"Tiempo de ejecucion (MPI): %f milisegundos\n"
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
	subq	$72, %rsp
	.cfi_def_cfa_offset 112
	movl	%edi, 28(%rsp)
	leaq	28(%rsp), %rdi
	movq	%rsi, 16(%rsp)
	leaq	16(%rsp), %rsi
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	movq	$0x000000000, 40(%rsp)
	movq	$0x000000000, 48(%rsp)
	call	MPI_Init@PLT
	leaq	32(%rsp), %rsi
	movq	%rbx, %rdi
	call	MPI_Comm_rank@PLT
	leaq	36(%rsp), %rsi
	movq	%rbx, %rdi
	call	MPI_Comm_size@PLT
	cmpl	$1, 28(%rsp)
	jle	.L16
	movq	16(%rsp), %rax
	movl	$10, %edx
	xorl	%esi, %esi
	movq	8(%rax), %rdi
	call	strtol@PLT
	movslq	36(%rsp), %rsi
	movslq	32(%rsp), %r12
	cqto
	movq	%rax, %rbp
	idivq	%rsi
	movq	%rsi, %rcx
	movq	%r12, %rdx
	subl	$1, %ecx
	imulq	%rax, %r12
	cmpl	%ecx, %edx
	je	.L12
	leaq	(%rax,%r12), %r13
.L5:
	movq	%rbx, %rdi
	call	MPI_Barrier@PLT
	call	MPI_Wtime@PLT
	cmpq	%r12, %r13
	vxorps	%xmm2, %xmm2, %xmm2
	vmovsd	%xmm0, (%rsp)
	jle	.L6
	movabsq	$2862933555777941757, %rdi
	movl	$3037000493, %eax
	vmovsd	40(%rsp), %xmm1
	vmovsd	.LC2(%rip), %xmm3
	imulq	%rdi, %r12
	imulq	%rdi, %r13
	leaq	(%r12,%rax), %rsi
	addq	%r13, %rax
	jmp	.L9
	.p2align 4,,10
	.p2align 3
.L18:
	vcvtsi2sdq	%rcx, %xmm2, %xmm0
	addq	%rdi, %rsi
	vmulsd	%xmm3, %xmm0, %xmm0
	vaddsd	%xmm0, %xmm1, %xmm1
	cmpq	%rsi, %rax
	je	.L17
.L9:
	movq	%rsi, %rdx
	shrq	$33, %rdx
	xorq	%rsi, %rdx
	imulq	%rdi, %rdx
	movq	%rdx, %rcx
	shrq	$33, %rcx
	xorq	%rdx, %rcx
	jns	.L18
	movq	%rcx, %rdx
	andl	$1, %ecx
	addq	%rdi, %rsi
	shrq	%rdx
	orq	%rcx, %rdx
	vcvtsi2sdq	%rdx, %xmm2, %xmm0
	vaddsd	%xmm0, %xmm0, %xmm0
	vmulsd	%xmm3, %xmm0, %xmm0
	vaddsd	%xmm0, %xmm1, %xmm1
	cmpq	%rsi, %rax
	jne	.L9
.L17:
	vmovsd	%xmm1, 40(%rsp)
.L6:
	leaq	48(%rsp), %rsi
	leaq	40(%rsp), %rdi
	pushq	%rax
	.cfi_def_cfa_offset 120
	xorl	%r9d, %r9d
	pushq	%rbx
	.cfi_def_cfa_offset 128
	leaq	ompi_mpi_double(%rip), %rcx
	movl	$1, %edx
	leaq	ompi_mpi_op_sum(%rip), %r8
	call	MPI_Reduce@PLT
	call	MPI_Wtime@PLT
	popq	%rdx
	.cfi_def_cfa_offset 120
	popq	%rcx
	.cfi_def_cfa_offset 112
	vxorps	%xmm2, %xmm2, %xmm2
	cmpl	$0, 32(%rsp)
	je	.L19
.L10:
	call	MPI_Finalize@PLT
	xorl	%eax, %eax
.L1:
	movq	56(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L20
	addq	$72, %rsp
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
.L16:
	.cfi_restore_state
	cmpl	$0, 32(%rsp)
	je	.L21
.L3:
	call	MPI_Finalize@PLT
	movl	$1, %eax
	jmp	.L1
.L12:
	movq	%rbp, %r13
	jmp	.L5
.L19:
	vcvtsi2sdq	%rbp, %xmm2, %xmm2
	vmovsd	%xmm0, 8(%rsp)
	vmovsd	48(%rsp), %xmm0
	leaq	.LC3(%rip), %rsi
	movl	$2, %edi
	movl	$1, %eax
	vdivsd	%xmm2, %xmm0, %xmm0
	call	__printf_chk@PLT
	vmovsd	8(%rsp), %xmm1
	vsubsd	(%rsp), %xmm1, %xmm0
	leaq	.LC5(%rip), %rsi
	vmulsd	.LC4(%rip), %xmm0, %xmm0
	movl	$2, %edi
	movl	$1, %eax
	call	__printf_chk@PLT
	jmp	.L10
.L21:
	movq	16(%rsp), %rax
	leaq	.LC1(%rip), %rsi
	movl	$2, %edi
	movq	(%rax), %rdx
	xorl	%eax, %eax
	call	__printf_chk@PLT
	jmp	.L3
.L20:
	call	__stack_chk_fail@PLT
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
