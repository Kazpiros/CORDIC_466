	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"cordic.c"
@ GNU C (Sourcery G++ Lite 2008q3-72) version 4.3.2 (arm-none-linux-gnueabi)
@	compiled by GNU C version 3.4.4, GMP version 4.2.2, MPFR version 2.3.1.
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -imultilib armv4t -iprefix
@ /opt/arm/4.3.2/bin/../lib/gcc/arm-none-linux-gnueabi/4.3.2/ -isysroot
@ /opt/arm/4.3.2/bin/../arm-none-linux-gnueabi/libc cordic.c -march=armv4t
@ -marm -auxbase-strip cordic.s -fverbose-asm
@ options enabled:  -falign-loops -fargument-alias -fauto-inc-dec
@ -fbranch-count-reg -fcommon -fearly-inlining
@ -feliminate-unused-debug-types -ffunction-cse -fgcse-lm -fident -fivopts
@ -fkeep-static-consts -fleading-underscore -fmath-errno
@ -fmerge-debug-strings -fmove-loop-invariants -fpeephole
@ -freg-struct-return -fsched-interblock -fsched-spec
@ -fsched-stalled-insns-dep -fsigned-zeros -fsplit-ivs-in-unroller
@ -ftoplevel-reorder -ftrapping-math -ftree-cselim -ftree-loop-im
@ -ftree-loop-ivcanon -ftree-loop-optimize -ftree-parallelize-loops=
@ -ftree-reassoc -ftree-scev-cprop -ftree-vect-loop-version -fverbose-asm
@ -fzero-initialized-in-bss -mglibc -mlittle-endian -msched-prolog
@ -mthumb-interwork

@ Compiler executable checksum: d3429b3d44dc83ee8ef5b80b6a06f8ca

	.global	zftable
	.data
	.align	2
	.type	zftable, %object
	.size	zftable, 64
zftable:
	.word	1110704128
	.word	1104446778
	.word	1096848500
	.word	1088684066
	.word	1080353450
	.word	1071979466
	.word	1063594523
	.word	1055206831
	.word	1046818452
	.word	1038429902
	.word	1030041308
	.word	1021652704
	.word	1013264096
	.word	1004875489
	.word	996486881
	.word	988098269
	.text
	.align	2
	.global	CORDIC_Rotating
	.type	CORDIC_Rotating, %function
CORDIC_Rotating:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!	@,
	add	fp, sp, #0	@,,
	sub	sp, sp, #52	@,,
	str	r0, [fp, #-16]	@ x, x
	str	r1, [fp, #-20]	@ y, y
	str	r2, [fp, #-24]	@ theta, theta
	str	r3, [fp, #-28]	@ ztable, ztable
	mov	r3, #0	@ tmp150,
	str	r3, [fp, #-8]	@ tmp150, i
	ldr	r3, [fp, #-16]	@ tmp151, x
	ldr	r3, [r3, #0]	@,
	str	r3, [fp, #-48]	@, x1
	ldr	r3, [fp, #-20]	@ tmp152, y
	ldr	r3, [r3, #0]	@,
	str	r3, [fp, #-44]	@, y1
	ldr	r3, [fp, #-24]	@ tmp153, theta
	ldr	r3, [r3, #0]	@,
	str	r3, [fp, #-40]	@, theta1
	b	.L2	@
.L5:
	ldr	r2, [fp, #-40]	@, theta1
	cmp	r2, #0	@,
	blt	.L3	@,
	ldr	r3, [fp, #-8]	@ tmp154, i
	ldr	r2, [fp, #-44]	@, y1
	mov	r3, r2, asr r3	@ D.2155,,
	ldr	r2, [fp, #-48]	@, x1
	rsb	r3, r3, r2	@, D.2155,
	str	r3, [fp, #-36]	@, x2
	ldr	r3, [fp, #-8]	@ tmp155, i
	ldr	r2, [fp, #-48]	@, x1
	mov	r3, r2, asr r3	@ D.2156,,
	ldr	r2, [fp, #-44]	@, y1
	add	r3, r3, r2	@, D.2156,
	str	r3, [fp, #-32]	@, y2
	ldr	r3, [fp, #-8]	@ i.0, i
	mov	r2, r3, asl #2	@ D.2158, i.0,
	ldr	r3, [fp, #-28]	@ tmp156, ztable
	add	r3, r3, r2	@ D.2159, tmp156, D.2158
	ldr	r3, [r3, #0]	@ D.2160,* D.2159
	ldr	r2, [fp, #-40]	@, theta1
	rsb	r2, r3, r2	@, D.2160,
	str	r2, [fp, #-40]	@, theta1
	b	.L4	@
.L3:
	ldr	r3, [fp, #-8]	@ tmp157, i
	ldr	r2, [fp, #-44]	@, y1
	mov	r3, r2, asr r3	@ D.2161,,
	ldr	r2, [fp, #-48]	@, x1
	add	r3, r3, r2	@, D.2161,
	str	r3, [fp, #-36]	@, x2
	ldr	r3, [fp, #-8]	@ tmp158, i
	ldr	r2, [fp, #-48]	@, x1
	mov	r3, r2, asr r3	@ D.2162,,
	ldr	r2, [fp, #-44]	@, y1
	rsb	r3, r3, r2	@, D.2162,
	str	r3, [fp, #-32]	@, y2
	ldr	r3, [fp, #-8]	@ i.1, i
	mov	r2, r3, asl #2	@ D.2164, i.1,
	ldr	r3, [fp, #-28]	@ tmp159, ztable
	add	r3, r3, r2	@ D.2165, tmp159, D.2164
	ldr	r3, [r3, #0]	@ D.2166,* D.2165
	ldr	r2, [fp, #-40]	@, theta1
	add	r2, r2, r3	@,, D.2166
	str	r2, [fp, #-40]	@, theta1
.L4:
	ldr	r3, [fp, #-36]	@, x2
	str	r3, [fp, #-48]	@, x1
	ldr	r2, [fp, #-32]	@, y2
	str	r2, [fp, #-44]	@, y1
	ldr	r3, [fp, #-8]	@ tmp160, i
	add	r3, r3, #1	@ tmp161, tmp160,
	str	r3, [fp, #-8]	@ tmp161, i
.L2:
	ldr	r3, [fp, #-8]	@ tmp162, i
	cmp	r3, #15	@ tmp162,
	ble	.L5	@,
	ldr	r3, [fp, #-16]	@ tmp163, x
	ldr	r2, [fp, #-48]	@, x1
	str	r2, [r3, #0]	@,
	ldr	r3, [fp, #-20]	@ tmp164, y
	ldr	r2, [fp, #-44]	@, y1
	str	r2, [r3, #0]	@,
	ldr	r3, [fp, #-24]	@ tmp165, theta
	ldr	r2, [fp, #-40]	@, theta1
	str	r2, [r3, #0]	@,
	add	sp, fp, #0	@,,
	ldmfd	sp!, {fp}
	bx	lr
	.size	CORDIC_Rotating, .-CORDIC_Rotating
	.align	2
	.global	CORDIC_Vectoring
	.type	CORDIC_Vectoring, %function
CORDIC_Vectoring:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 48
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	str	fp, [sp, #-4]!	@,
	add	fp, sp, #0	@,,
	sub	sp, sp, #52	@,,
	str	r0, [fp, #-16]	@ x, x
	str	r1, [fp, #-20]	@ y, y
	str	r2, [fp, #-24]	@ z, z
	str	r3, [fp, #-28]	@ ztable, ztable
	mov	r3, #0	@ tmp150,
	str	r3, [fp, #-8]	@ tmp150, i
	ldr	r3, [fp, #-16]	@ tmp151, x
	ldr	r3, [r3, #0]	@,
	str	r3, [fp, #-48]	@, x1
	ldr	r3, [fp, #-20]	@ tmp152, y
	ldr	r3, [r3, #0]	@,
	str	r3, [fp, #-44]	@, y1
	mov	r2, #0	@,
	str	r2, [fp, #-40]	@, z1
	b	.L8	@
.L11:
	ldr	r3, [fp, #-44]	@, y1
	cmp	r3, #0	@,
	blt	.L9	@,
	ldr	r3, [fp, #-8]	@ tmp153, i
	ldr	r2, [fp, #-44]	@, y1
	mov	r3, r2, asr r3	@ D.2185,,
	ldr	r2, [fp, #-48]	@, x1
	add	r3, r3, r2	@, D.2185,
	str	r3, [fp, #-36]	@, x2
	ldr	r3, [fp, #-8]	@ tmp154, i
	ldr	r2, [fp, #-48]	@, x1
	mov	r3, r2, asr r3	@ D.2186,,
	ldr	r2, [fp, #-44]	@, y1
	rsb	r3, r3, r2	@, D.2186,
	str	r3, [fp, #-32]	@, y2
	ldr	r3, [fp, #-8]	@ i.2, i
	mov	r2, r3, asl #2	@ D.2188, i.2,
	ldr	r3, [fp, #-28]	@ tmp155, ztable
	add	r3, r3, r2	@ D.2189, tmp155, D.2188
	ldr	r3, [r3, #0]	@ D.2190,* D.2189
	ldr	r2, [fp, #-40]	@, z1
	add	r2, r2, r3	@,, D.2190
	str	r2, [fp, #-40]	@, z1
	b	.L10	@
.L9:
	ldr	r3, [fp, #-8]	@ tmp156, i
	ldr	r2, [fp, #-44]	@, y1
	mov	r3, r2, asr r3	@ D.2191,,
	ldr	r2, [fp, #-48]	@, x1
	rsb	r3, r3, r2	@, D.2191,
	str	r3, [fp, #-36]	@, x2
	ldr	r3, [fp, #-8]	@ tmp157, i
	ldr	r2, [fp, #-48]	@, x1
	mov	r3, r2, asr r3	@ D.2192,,
	ldr	r2, [fp, #-44]	@, y1
	add	r3, r3, r2	@, D.2192,
	str	r3, [fp, #-32]	@, y2
	ldr	r3, [fp, #-8]	@ i.3, i
	mov	r2, r3, asl #2	@ D.2194, i.3,
	ldr	r3, [fp, #-28]	@ tmp158, ztable
	add	r3, r3, r2	@ D.2195, tmp158, D.2194
	ldr	r3, [r3, #0]	@ D.2196,* D.2195
	ldr	r2, [fp, #-40]	@, z1
	rsb	r2, r3, r2	@, D.2196,
	str	r2, [fp, #-40]	@, z1
.L10:
	ldr	r3, [fp, #-36]	@, x2
	str	r3, [fp, #-48]	@, x1
	ldr	r2, [fp, #-32]	@, y2
	str	r2, [fp, #-44]	@, y1
	ldr	r3, [fp, #-8]	@ tmp159, i
	add	r3, r3, #1	@ tmp160, tmp159,
	str	r3, [fp, #-8]	@ tmp160, i
.L8:
	ldr	r3, [fp, #-8]	@ tmp161, i
	cmp	r3, #15	@ tmp161,
	ble	.L11	@,
	ldr	r3, [fp, #-16]	@ tmp162, x
	ldr	r2, [fp, #-48]	@, x1
	str	r2, [r3, #0]	@,
	ldr	r3, [fp, #-20]	@ tmp163, y
	ldr	r2, [fp, #-44]	@, y1
	str	r2, [r3, #0]	@,
	ldr	r3, [fp, #-24]	@ tmp164, z
	ldr	r2, [fp, #-40]	@, z1
	str	r2, [r3, #0]	@,
	add	sp, fp, #0	@,,
	ldmfd	sp!, {fp}
	bx	lr
	.size	CORDIC_Vectoring, .-CORDIC_Vectoring
	.section	.rodata
	.align	2
.LC0:
	.ascii	"cordic0!\000"
	.global	__aeabi_dmul
	.global	__aeabi_d2iz
	.align	2
.LC1:
	.ascii	"Debug prints:\012\000"
	.align	2
.LC2:
	.ascii	"64-bit float x_d = %f\011\011\01116-bit int x_i = %"
	.ascii	"i\012\000"
	.align	2
.LC3:
	.ascii	"64-bit float y_d = %f\011\011\01116-bit int y_i = %"
	.ascii	"i\012\000"
	.align	2
.LC4:
	.ascii	"64-bit float z_d = %f\011\011\01116-bit int z_i = %"
	.ascii	"i\012\000"
	.global	__aeabi_f2d
	.align	2
.LC5:
	.ascii	"\012\012Results of CORDIC_Vectoring:\012\000"
	.global	__aeabi_i2d
	.global	__aeabi_ddiv
	.align	2
.LC6:
	.ascii	"Scaled magnitude result x_i = %.12f\012\000"
	.align	2
.LC7:
	.ascii	"Angle of vector result z_i = %.12f\012\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 112
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, fp, lr}	@,
	add	fp, sp, #20	@,,
	sub	sp, sp, #120	@,,
	ldr	r0, .L17+24	@,
	bl	puts	@
	adr	r4, .L17	@,
	ldmia	r4, {r3-r4}	@, tmp157
	str	r3, [fp, #-52]	@ tmp157, x_d
	str	r4, [fp, #-48]	@, x_d
	adr	r4, .L17+8	@,
	ldmia	r4, {r3-r4}	@, tmp158
	str	r3, [fp, #-44]	@ tmp158, y_d
	str	r4, [fp, #-40]	@, y_d
	mov	r3, #0	@ tmp159,
	mov	r4, #0	@,
	str	r3, [fp, #-36]	@ tmp159, z_d
	str	r4, [fp, #-32]	@, z_d
	sub	r4, fp, #52	@,,
	ldmia	r4, {r3-r4}	@, tmp160
	mov	r5, #0	@ tmp161,
	mov	r6, #1073741824	@,
	add	r6, r6, #14680064	@,,
	mov	r0, r3	@, tmp160
	mov	r1, r4	@,
	mov	r2, r5	@, tmp161
	mov	r3, r6	@,
	bl	__aeabi_dmul	@
	mov	r3, r0	@ tmp162,
	mov	r4, r1	@,
	mov	r0, r3	@, D.2213
	mov	r1, r4	@, D.2213
	bl	__aeabi_d2iz	@
	mov	r3, r0	@ x_i.4,
	str	r3, [fp, #-120]	@ x_i.4, x_i
	sub	r4, fp, #44	@,,
	ldmia	r4, {r3-r4}	@, tmp163
	mov	r5, #0	@ tmp164,
	mov	r6, #1073741824	@,
	add	r6, r6, #14680064	@,,
	mov	r0, r3	@, tmp163
	mov	r1, r4	@,
	mov	r2, r5	@, tmp164
	mov	r3, r6	@,
	bl	__aeabi_dmul	@
	mov	r3, r0	@ tmp165,
	mov	r4, r1	@,
	mov	r0, r3	@, D.2215
	mov	r1, r4	@, D.2215
	bl	__aeabi_d2iz	@
	mov	r3, r0	@ y_i.5,
	str	r3, [fp, #-124]	@ y_i.5, y_i
	sub	r4, fp, #36	@,,
	ldmia	r4, {r3-r4}	@, tmp166
	mov	r5, #0	@ tmp167,
	mov	r6, #1073741824	@,
	add	r6, r6, #14680064	@,,
	mov	r0, r3	@, tmp166
	mov	r1, r4	@,
	mov	r2, r5	@, tmp167
	mov	r3, r6	@,
	bl	__aeabi_dmul	@
	mov	r3, r0	@ tmp168,
	mov	r4, r1	@,
	mov	r0, r3	@, D.2217
	mov	r1, r4	@, D.2217
	bl	__aeabi_d2iz	@
	mov	r3, r0	@ z_i.6,
	str	r3, [fp, #-128]	@ z_i.6, z_i
	ldr	r0, .L17+28	@,
	bl	puts	@
	ldr	r3, [fp, #-120]	@ x_i.7, x_i
	str	r3, [sp, #0]	@ x_i.7,
	ldr	r0, .L17+32	@,
	sub	r3, fp, #52	@,,
	ldmia	r3, {r2-r3}	@,
	bl	printf	@
	ldr	r3, [fp, #-124]	@ y_i.8, y_i
	str	r3, [sp, #0]	@ y_i.8,
	ldr	r0, .L17+36	@,
	sub	r3, fp, #44	@,,
	ldmia	r3, {r2-r3}	@,
	bl	printf	@
	ldr	r3, [fp, #-128]	@ z_i.9, z_i
	str	r3, [sp, #0]	@ z_i.9,
	ldr	r0, .L17+40	@,
	sub	r3, fp, #36	@,,
	ldmia	r3, {r2-r3}	@,
	bl	printf	@
	mov	r3, #0	@ tmp169,
	str	r3, [fp, #-24]	@ tmp169, i
	b	.L14	@
.L15:
	ldr	r7, [fp, #-24]	@ i.10, i
	ldr	r2, [fp, #-24]	@ i.11, i
	ldr	r3, .L17+44	@ tmp170,
	ldr	r3, [r3, r2, asl #2]	@ float	@ D.2224, zftable
	mov	r0, r3	@, D.2224
	bl	__aeabi_f2d	@
	mov	r3, r0	@ D.2225,
	mov	r4, r1	@ D.2225,
	mov	r5, #0	@ tmp171,
	mov	r6, #1073741824	@,
	add	r6, r6, #14680064	@,,
	mov	r0, r3	@, D.2225
	mov	r1, r4	@, D.2225
	mov	r2, r5	@, tmp171
	mov	r3, r6	@,
	bl	__aeabi_dmul	@
	mov	r3, r0	@ tmp172,
	mov	r4, r1	@,
	mov	r0, r3	@, D.2226
	mov	r1, r4	@, D.2226
	bl	__aeabi_d2iz	@
	mov	r1, r0	@ D.2227,
	mvn	r2, #95	@ tmp173,
	mov	r3, r7, asl #2	@ tmp174, i.10,
	sub	r0, fp, #20	@,,
	add	r3, r0, r3	@ tmp175,, tmp174
	add	r3, r3, r2	@ tmp176, tmp175, tmp173
	str	r1, [r3, #0]	@ D.2227, zitable
	ldr	r3, [fp, #-24]	@ tmp177, i
	add	r3, r3, #1	@ tmp178, tmp177,
	str	r3, [fp, #-24]	@ tmp178, i
.L14:
	ldr	r3, [fp, #-24]	@ tmp179, i
	cmp	r3, #15	@ tmp179,
	ble	.L15	@,
	sub	r3, fp, #120	@ tmp180,,
	sub	r2, fp, #124	@ tmp181,,
	sub	ip, fp, #128	@ tmp182,,
	sub	lr, fp, #116	@ tmp183,,
	mov	r0, r3	@, tmp180
	mov	r1, r2	@, tmp181
	mov	r2, ip	@, tmp182
	mov	r3, lr	@, tmp183
	bl	CORDIC_Vectoring	@
	ldr	r0, .L17+48	@,
	bl	puts	@
	ldr	r3, [fp, #-120]	@ x_i.12, x_i
	mov	r0, r3	@, x_i.12
	bl	__aeabi_i2d	@
	mov	r3, r0	@ D.2229,
	mov	r4, r1	@ D.2229,
	mov	r5, #0	@ tmp184,
	mov	r6, #1073741824	@,
	add	r6, r6, #14680064	@,,
	mov	r0, r3	@, D.2229
	mov	r1, r4	@, D.2229
	mov	r2, r5	@, tmp184
	mov	r3, r6	@,
	bl	__aeabi_ddiv	@
	mov	r3, r0	@ tmp185,
	mov	r4, r1	@,
	adr	r6, .L17+16	@,
	ldmia	r6, {r5-r6}	@, tmp186
	mov	r0, r3	@, D.2230
	mov	r1, r4	@, D.2230
	mov	r2, r5	@, tmp186
	mov	r3, r6	@,
	bl	__aeabi_ddiv	@
	mov	r3, r0	@ tmp187,
	mov	r4, r1	@,
	ldr	r0, .L17+52	@,
	mov	r2, r3	@, D.2231
	mov	r3, r4	@, D.2231
	bl	printf	@
	ldr	r3, [fp, #-128]	@ z_i.13, z_i
	mov	r0, r3	@, z_i.13
	bl	__aeabi_i2d	@
	mov	r3, r0	@ D.2233,
	mov	r4, r1	@ D.2233,
	mov	r5, #0	@ tmp188,
	mov	r6, #1073741824	@,
	add	r6, r6, #14680064	@,,
	mov	r0, r3	@, D.2233
	mov	r1, r4	@, D.2233
	mov	r2, r5	@, tmp188
	mov	r3, r6	@,
	bl	__aeabi_ddiv	@
	mov	r3, r0	@ tmp189,
	mov	r4, r1	@,
	ldr	r0, .L17+56	@,
	mov	r2, r3	@, D.2234
	mov	r3, r4	@, D.2234
	bl	printf	@
	mov	r3, #0	@ D.2235,
	mov	r0, r3	@, <result>
	sub	sp, fp, #20	@,,
	ldmfd	sp!, {r4, r5, r6, r7, fp, lr}
	bx	lr
.L18:
	.align	3
.L17:
	.word	858993459
	.word	1072378675
	.word	-2061584302
	.word	1072189931
	.word	1221297670
	.word	1073371425
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	zftable
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.size	main, .-main
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
