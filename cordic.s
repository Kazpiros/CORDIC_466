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

	.data
	.align	2
	.type	NAN, %object
	.size	NAN, 4
NAN:
	.word	2143289344
	.global	z_table
	.align	2
	.type	z_table, %object
	.size	z_table, 64
z_table:
	.word	1236533248
	.word	1230275888
	.word	1222677600
	.word	1214513152
	.word	1206182528
	.word	1197808384
	.word	1189423616
	.word	1181035520
	.word	1172645888
	.word	1164255232
	.word	1155866624
	.word	1147469824
	.word	1139081216
	.word	1130692608
	.word	1122238464
	.word	1113849856
	.global	__aeabi_f2iz
	.text
	.align	2
	.type	CORDIC_Rotating, %function
CORDIC_Rotating:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}	@,
	add	fp, sp, #4	@,,
	sub	sp, sp, #40	@,,
	str	r0, [fp, #-16]	@ x, x
	str	r1, [fp, #-20]	@ y, y
	str	r2, [fp, #-24]	@ theta, theta
	mov	r0, #0	@,
	str	r0, [fp, #-44]	@, i
	ldr	r3, [fp, #-16]	@ tmp150, x
	ldr	r3, [r3, #0]	@,
	str	r3, [fp, #-40]	@, x1
	ldr	r3, [fp, #-20]	@ tmp151, y
	ldr	r3, [r3, #0]	@,
	str	r3, [fp, #-36]	@, y1
	ldr	r3, [fp, #-24]	@ tmp152, theta
	ldr	r3, [r3, #0]	@,
	str	r3, [fp, #-32]	@, theta1
	ldr	r3, .L5	@ tmp153,
	ldr	r3, [r3, #0]	@ float	@ D.1652, z_table
	mov	r0, r3	@, D.1652
	bl	__aeabi_f2iz	@
	mov	r3, r0	@ tmp154,
	str	r3, [fp, #-28]	@ tmp154, next_z
	b	.L2	@
.L3:
	ldr	r1, [fp, #-32]	@, theta1
	mov	r2, #1	@, D.1653(SIGN START)						     1 CYCLE
	ldr	r0, [fp, #-32]	@, theta1								 
	mov	r3, r0, asr #31	@ D.1654,,                               2 CYCLE
	orr	r3, r2, r3	@ tmp155, D.1653, D.1654                     1 CYCLE
	str	r3, [fp, #-8]	@ tmp155, sign							 2 CYCLES? 
	ldr	r1, [fp, #-36]	@, y1
	ldr	r3, [fp, #-44]	@, i
	mov	r2, r1, asr r3	@ D.1655,,
	ldr	r3, [fp, #-8]	@ tmp156, sign
	mul	r3, r2, r3	@ D.1656, D.1655, tmp156
	ldr	r0, [fp, #-40]	@, x1
	rsb	r1, r3, r0	@ x2, D.1656,
	ldr	r3, [fp, #-40]	@, x1
	ldr	r0, [fp, #-44]	@, i
	mov	r2, r3, asr r0	@ D.1657,,
	ldr	r3, [fp, #-8]	@ tmp157, sign
	mul	r3, r2, r3	@ D.1658, D.1657, tmp157
	ldr	r0, [fp, #-36]	@, y1
	add	r2, r3, r0	@ y2, D.1658,
	ldr	r3, [fp, #-8]	@ tmp158, sign
	ldr	r0, [fp, #-28]	@, next_z
	mul	r3, r0, r3	@ D.1659,, tmp158
	ldr	r0, [fp, #-32]	@, theta1
	rsb	r0, r3, r0	@, D.1659,
	str	r0, [fp, #-32]	@, theta1
	str	r1, [fp, #-40]	@ x2, x1
	str	r2, [fp, #-36]	@ y2, y1
	ldr	r1, [fp, #-44]	@, i
	add	r1, r1, #1	@,,
	str	r1, [fp, #-44]	@, i
	ldr	r2, [fp, #-44]	@ i.0, i
	ldr	r3, .L5	@ tmp159,
	ldr	r3, [r3, r2, asl #2]	@ float	@ D.1661, z_table
	mov	r0, r3	@, D.1661
	bl	__aeabi_f2iz	@
	mov	r3, r0	@ tmp160,
	str	r3, [fp, #-28]	@ tmp160, next_z
.L2:
	ldr	r2, [fp, #-44]	@, i                  2 CYCLES
	cmp	r2, #3	@,							  1 CYCLE
	ble	.L3	@,                                3 CYCLES
	ldr	r3, [fp, #-16]	@ tmp161, x
	ldr	r0, [fp, #-40]	@, x1
	str	r0, [r3, #0]	@,
	ldr	r3, [fp, #-20]	@ tmp162, y
	ldr	r1, [fp, #-36]	@, y1
	str	r1, [r3, #0]	@,
	ldr	r3, [fp, #-24]	@ tmp163, theta
	ldr	r2, [fp, #-32]	@, theta1
	str	r2, [r3, #0]	@,
	sub	sp, fp, #4	@,,
	ldmfd	sp!, {fp, lr}
	bx	lr                                     
.L6:
	.align	2
.L5:
	.word	z_table
	.size	CORDIC_Rotating, .-CORDIC_Rotating
	.align	2
	.type	CORDIC_Vectoring, %function
CORDIC_Vectoring:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}	@,
	add	fp, sp, #4	@,,
	sub	sp, sp, #40	@,,
	str	r0, [fp, #-16]	@ x, x
	str	r1, [fp, #-20]	@ y, y
	str	r2, [fp, #-24]	@ z, z
	mov	r0, #0	@,
	str	r0, [fp, #-44]	@, i
	ldr	r3, [fp, #-16]	@ tmp150, x
	ldr	r3, [r3, #0]	@,
	str	r3, [fp, #-40]	@, x1
	ldr	r3, [fp, #-20]	@ tmp151, y
	ldr	r3, [r3, #0]	@,
	str	r3, [fp, #-36]	@, y1
	mov	r1, #0	@,
	str	r1, [fp, #-32]	@, z1
	ldr	r3, .L11	@ tmp152,
	ldr	r3, [r3, #0]	@ float	@ D.1678, z_table
	mov	r0, r3	@, D.1678
	bl	__aeabi_f2iz	@
	mov	r3, r0	@ tmp153,
	str	r3, [fp, #-28]	@ tmp153, next_z
	b	.L8	@
.L9:
	ldr	r2, [fp, #-36]	@, y1
	mov	r2, #1	@, D.1679
	ldr	r0, [fp, #-36]	@, y1
	mov	r3, r0, asr #31	@ D.1680,,
	orr	r3, r2, r3	@ tmp154, D.1679, D.1680
	str	r3, [fp, #-8]	@ tmp154, sign
	ldr	r1, [fp, #-36]	@, y1
	ldr	r3, [fp, #-44]	@, i
	mov	r2, r1, asr r3	@ D.1681,,
	ldr	r3, [fp, #-8]	@ tmp155, sign
	mul	r3, r2, r3	@ D.1682, D.1681, tmp155
	ldr	r0, [fp, #-40]	@, x1
	add	r1, r3, r0	@ x2, D.1682,
	ldr	r3, [fp, #-40]	@, x1
	ldr	r0, [fp, #-44]	@, i
	mov	r2, r3, asr r0	@ D.1683,,
	ldr	r3, [fp, #-8]	@ tmp156, sign
	mul	r3, r2, r3	@ D.1684, D.1683, tmp156
	ldr	r0, [fp, #-36]	@, y1
	rsb	r2, r3, r0	@ y2, D.1684,
	ldr	r3, [fp, #-8]	@ tmp157, sign
	ldr	r0, [fp, #-28]	@, next_z
	mul	r3, r0, r3	@ D.1685,, tmp157
	ldr	r0, [fp, #-32]	@, z1
	add	r0, r0, r3	@,, D.1685
	str	r0, [fp, #-32]	@, z1
	str	r1, [fp, #-40]	@ x2, x1
	str	r2, [fp, #-36]	@ y2, y1
	ldr	r1, [fp, #-44]	@, i
	add	r1, r1, #1	@,,
	str	r1, [fp, #-44]	@, i
	ldr	r2, [fp, #-44]	@ i.1, i
	ldr	r3, .L11	@ tmp158,
	ldr	r3, [r3, r2, asl #2]	@ float	@ D.1687, z_table
	mov	r0, r3	@, D.1687
	bl	__aeabi_f2iz	@
	mov	r3, r0	@ tmp159,
	str	r3, [fp, #-28]	@ tmp159, next_z
.L8:
	ldr	r2, [fp, #-44]	@, i
	cmp	r2, #3	@,
	ble	.L9	@,
	ldr	r3, [fp, #-16]	@ tmp160, x
	ldr	r0, [fp, #-40]	@, x1
	str	r0, [r3, #0]	@,
	ldr	r3, [fp, #-20]	@ tmp161, y
	ldr	r1, [fp, #-36]	@, y1
	str	r1, [r3, #0]	@,
	ldr	r3, [fp, #-24]	@ tmp162, z
	ldr	r2, [fp, #-32]	@, z1
	str	r2, [r3, #0]	@,
	sub	sp, fp, #4	@,,
	ldmfd	sp!, {fp, lr}
	bx	lr
.L12:
	.align	2
.L11:
	.word	z_table
	.size	CORDIC_Vectoring, .-CORDIC_Vectoring
	.global	__aeabi_f2d
	.global	__aeabi_dmul
	.global	__aeabi_dadd
	.global	__aeabi_d2iz
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Debug prints:\012\000"
	.align	2
.LC1:
	.ascii	"64-bit float x_d = %f\011\011\01116-bit int x_i = %"
	.ascii	"i\012\000"
	.align	2
.LC2:
	.ascii	"64-bit float y_d = %f\011\011\01116-bit int y_i = %"
	.ascii	"i\012\000"
	.align	2
.LC3:
	.ascii	"64-bit float z_d = %f\011\011\01116-bit int z_i = %"
	.ascii	"i\012\000"
	.global	__aeabi_i2d
	.global	__aeabi_dcmpeq
	.global	__aeabi_i2f
	.global	__aeabi_ddiv
	.global	__aeabi_d2f
	.align	2
.LC4:
	.ascii	"\012\012Results of CORDIC_Vectoring:\012\000"
	.align	2
.LC5:
	.ascii	"Scaled magnitude result x_i = %.12f\012\000"
	.align	2
.LC6:
	.ascii	"Angle of vector result z_i = %.12f\012\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, fp, lr}	@,
	add	fp, sp, #16	@,,
	sub	sp, sp, #52	@,,
	ldr	r3, .L20+16	@ float	@ tmp166,
	str	r3, [fp, #-36]	@ float	@ tmp166, x_d
	ldr	r3, .L20+20	@ float	@ tmp167,
	str	r3, [fp, #-32]	@ float	@ tmp167, y_d
	ldr	r3, .L20+20	@ float	@ tmp168,
	str	r3, [fp, #-28]	@ float	@ tmp168, z_d
	ldr	r0, [fp, #-36]	@ float	@, x_d
	bl	__aeabi_f2d	@
	mov	r3, r0	@ D.1697,
	mov	r4, r1	@ D.1697,
	mov	r5, #0	@ tmp169,
	mov	r6, #1073741824	@,
	add	r6, r6, #14680064	@,,
	mov	r0, r3	@, D.1697
	mov	r1, r4	@, D.1697
	mov	r2, r5	@, tmp169
	mov	r3, r6	@,
	bl	__aeabi_dmul	@
	mov	r3, r0	@ tmp170,
	mov	r4, r1	@,
	mov	r5, #0	@ tmp171,
	mov	r6, #1069547520	@,
	add	r6, r6, #2097152	@,,
	mov	r0, r3	@, D.1698
	mov	r1, r4	@, D.1698
	mov	r2, r5	@, tmp171
	mov	r3, r6	@,
	bl	__aeabi_dadd	@
	mov	r3, r0	@ tmp172,
	mov	r4, r1	@,
	mov	r0, r3	@, D.1699
	mov	r1, r4	@, D.1699
	bl	__aeabi_d2iz	@
	mov	r3, r0	@ x_i.2,
	str	r3, [fp, #-40]	@ x_i.2, x_i
	ldr	r0, [fp, #-32]	@ float	@, y_d
	bl	__aeabi_f2d	@
	mov	r3, r0	@ D.1701,
	mov	r4, r1	@ D.1701,
	mov	r5, #0	@ tmp173,
	mov	r6, #1073741824	@,
	add	r6, r6, #14680064	@,,
	mov	r0, r3	@, D.1701
	mov	r1, r4	@, D.1701
	mov	r2, r5	@, tmp173
	mov	r3, r6	@,
	bl	__aeabi_dmul	@
	mov	r3, r0	@ tmp174,
	mov	r4, r1	@,
	mov	r5, #0	@ tmp175,
	mov	r6, #1069547520	@,
	add	r6, r6, #2097152	@,,
	mov	r0, r3	@, D.1702
	mov	r1, r4	@, D.1702
	mov	r2, r5	@, tmp175
	mov	r3, r6	@,
	bl	__aeabi_dadd	@
	mov	r3, r0	@ tmp176,
	mov	r4, r1	@,
	mov	r0, r3	@, D.1703
	mov	r1, r4	@, D.1703
	bl	__aeabi_d2iz	@
	mov	r3, r0	@ y_i.3,
	str	r3, [fp, #-44]	@ y_i.3, y_i
	ldr	r0, [fp, #-28]	@ float	@, z_d
	bl	__aeabi_f2d	@
	mov	r3, r0	@ D.1705,
	mov	r4, r1	@ D.1705,
	mov	r5, #0	@ tmp177,
	mov	r6, #1073741824	@,
	add	r6, r6, #14680064	@,,
	mov	r0, r3	@, D.1705
	mov	r1, r4	@, D.1705
	mov	r2, r5	@, tmp177
	mov	r3, r6	@,
	bl	__aeabi_dmul	@
	mov	r3, r0	@ tmp178,
	mov	r4, r1	@,
	mov	r5, #0	@ tmp179,
	mov	r6, #1069547520	@,
	add	r6, r6, #2097152	@,,
	mov	r0, r3	@, D.1706
	mov	r1, r4	@, D.1706
	mov	r2, r5	@, tmp179
	mov	r3, r6	@,
	bl	__aeabi_dadd	@
	mov	r3, r0	@ tmp180,
	mov	r4, r1	@,
	mov	r0, r3	@, D.1707
	mov	r1, r4	@, D.1707
	bl	__aeabi_d2iz	@
	mov	r3, r0	@ z_i.4,
	str	r3, [fp, #-48]	@ z_i.4, z_i
	ldr	r0, .L20+24	@,
	bl	puts	@
	ldr	r0, [fp, #-36]	@ float	@, x_d
	bl	__aeabi_f2d	@
	mov	r2, r1	@ D.1709,
	mov	r1, r0	@ D.1709,
	ldr	r3, [fp, #-40]	@ x_i.5, x_i
	str	r3, [sp, #0]	@ x_i.5,
	ldr	r0, .L20+28	@,
	mov	r3, r2	@, D.1709
	mov	r2, r1	@, D.1709
	bl	printf	@
	ldr	r0, [fp, #-32]	@ float	@, y_d
	bl	__aeabi_f2d	@
	mov	r2, r1	@ D.1711,
	mov	r1, r0	@ D.1711,
	ldr	r3, [fp, #-44]	@ y_i.6, y_i
	str	r3, [sp, #0]	@ y_i.6,
	ldr	r0, .L20+32	@,
	mov	r3, r2	@, D.1711
	mov	r2, r1	@, D.1711
	bl	printf	@
	ldr	r0, [fp, #-28]	@ float	@, z_d
	bl	__aeabi_f2d	@
	mov	r2, r1	@ D.1713,
	mov	r1, r0	@ D.1713,
	ldr	r3, [fp, #-48]	@ z_i.7, z_i
	str	r3, [sp, #0]	@ z_i.7,
	ldr	r0, .L20+36	@,
	mov	r3, r2	@, D.1713
	mov	r2, r1	@, D.1713
	bl	printf	@
	ldr	r3, [fp, #-40]	@ x_i.9, x_i
	mov	r0, r3	@, x_i.9
	bl	__aeabi_i2d	@
	mov	r3, r0	@ D.1717,
	mov	r4, r1	@ D.1717,
	mov	r0, r3	@, D.1717
	mov	r1, r4	@, D.1717
	mov	r2, #0	@,
	mov	r3, #0	@,
	bl	__aeabi_dcmpeq	@
	mov	r3, r0	@ tmp181,
	cmp	r3, #0	@ tmp181,
	beq	.L19	@,
.L18:
	ldr	r3, .L20+40	@ tmp182,
	ldr	r3, [r3, #0]	@ float	@, NAN
	str	r3, [fp, #-56]	@ float	@, iftmp.8
	b	.L16	@
.L19:
	ldr	r3, [fp, #-40]	@ x_i.10, x_i
	mov	r0, r3	@, x_i.10
	bl	__aeabi_i2f	@
	mov	r3, r0	@ D.1719,
	mov	r0, r3	@, D.1719
	bl	__aeabi_f2d	@
	mov	r3, r0	@ D.1720,
	mov	r4, r1	@ D.1720,
	adr	r6, .L20	@,
	ldmia	r6, {r5-r6}	@, tmp183
	mov	r0, r3	@, D.1720
	mov	r1, r4	@, D.1720
	mov	r2, r5	@, tmp183
	mov	r3, r6	@,
	bl	__aeabi_ddiv	@
	mov	r3, r0	@ tmp184,
	mov	r4, r1	@,
	mov	r0, r3	@, D.1721
	mov	r1, r4	@, D.1721
	bl	__aeabi_d2f	@
	str	r0, [fp, #-56]	@ float	@, iftmp.8
.L16:
	ldr	r3, [fp, #-56]	@ float	@, iftmp.8
	str	r3, [fp, #-24]	@ float	@, x_out
	sub	r3, fp, #40	@ tmp185,,
	sub	r2, fp, #44	@ tmp186,,
	sub	ip, fp, #48	@ tmp187,,
	mov	r0, r3	@, tmp185
	mov	r1, r2	@, tmp186
	mov	r2, ip	@, tmp187
	bl	CORDIC_Vectoring	@
	ldr	r0, .L20+44	@,
	bl	puts	@
	ldr	r0, [fp, #-24]	@ float	@, x_out
	bl	__aeabi_f2d	@
	mov	r3, r0	@ D.1722,
	mov	r4, r1	@ D.1722,
	mov	r5, #0	@ tmp188,
	mov	r6, #1073741824	@,
	add	r6, r6, #14680064	@,,
	mov	r0, r3	@, D.1722
	mov	r1, r4	@, D.1722
	mov	r2, r5	@, tmp188
	mov	r3, r6	@,
	bl	__aeabi_ddiv	@
	mov	r3, r0	@ tmp189,
	mov	r4, r1	@,
	adr	r6, .L20+8	@,
	ldmia	r6, {r5-r6}	@, tmp190
	mov	r0, r3	@, D.1723
	mov	r1, r4	@, D.1723
	mov	r2, r5	@, tmp190
	mov	r3, r6	@,
	bl	__aeabi_ddiv	@
	mov	r3, r0	@ tmp191,
	mov	r4, r1	@,
	ldr	r0, .L20+48	@,
	mov	r2, r3	@, D.1724
	mov	r3, r4	@, D.1724
	bl	printf	@
	ldr	r3, [fp, #-48]	@ z_i.11, z_i
	mov	r0, r3	@, z_i.11
	bl	__aeabi_i2d	@
	mov	r3, r0	@ D.1726,
	mov	r4, r1	@ D.1726,
	mov	r5, #0	@ tmp192,
	mov	r6, #1073741824	@,
	add	r6, r6, #14680064	@,,
	mov	r0, r3	@, D.1726
	mov	r1, r4	@, D.1726
	mov	r2, r5	@, tmp192
	mov	r3, r6	@,
	bl	__aeabi_ddiv	@
	mov	r3, r0	@ tmp193,
	mov	r4, r1	@,
	ldr	r0, .L20+52	@,
	mov	r2, r3	@, D.1727
	mov	r3, r4	@, D.1727
	bl	printf	@
	mov	r3, #0	@ D.1728,
	mov	r0, r3	@, <result>
	sub	sp, fp, #16	@,,
	ldmfd	sp!, {r4, r5, r6, fp, lr}
	bx	lr
.L21:
	.align	3
.L20:
	.word	-1257538936
	.word	1087598237
	.word	1221297670
	.word	1073371425
	.word	1065353216
	.word	0
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	NAN
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.size	main, .-main
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
