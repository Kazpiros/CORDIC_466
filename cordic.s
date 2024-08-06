	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 18, 4
	.file	"cordic.c"
@ GNU C (Sourcery G++ Lite 2008q3-72) version 4.3.2 (arm-none-linux-gnueabi)
@	compiled by GNU C version 3.4.4, GMP version 4.2.2, MPFR version 2.3.1.
@ GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
@ options passed:  -imultilib armv4t -iprefix
@ /opt/arm/4.3.2/bin/../lib/gcc/arm-none-linux-gnueabi/4.3.2/ -isysroot
@ /opt/arm/4.3.2/bin/../arm-none-linux-gnueabi/libc cordic.c -march=armv4t
@ -marm -auxbase-strip cordic.s -O3 -fverbose-asm
@ options enabled:  -falign-loops -fargument-alias -fauto-inc-dec
@ -fbranch-count-reg -fcaller-saves -fcommon -fcprop-registers
@ -fcrossjumping -fcse-follow-jumps -fdefer-pop
@ -fdelete-null-pointer-checks -fearly-inlining
@ -feliminate-unused-debug-types -fexpensive-optimizations
@ -fforward-propagate -ffunction-cse -fgcse -fgcse-after-reload -fgcse-lm
@ -fguess-branch-probability -fident -fif-conversion -fif-conversion2
@ -finline-functions -finline-functions-called-once
@ -finline-small-functions -fipa-pure-const -fipa-reference -fivopts
@ -fkeep-static-consts -fleading-underscore -fmath-errno -fmerge-constants
@ -fmerge-debug-strings -fmove-loop-invariants -fomit-frame-pointer
@ -foptimize-register-move -foptimize-sibling-calls -fpeephole -fpeephole2
@ -fpredictive-commoning -freg-struct-return -fregmove -freorder-blocks
@ -freorder-functions -frerun-cse-after-loop -fsched-interblock
@ -fsched-spec -fsched-stalled-insns-dep -fschedule-insns -fschedule-insns2
@ -fsection-anchors -fsigned-zeros -fsplit-ivs-in-unroller
@ -fsplit-wide-types -fstrict-aliasing -fstrict-overflow -fthread-jumps
@ -ftoplevel-reorder -ftrapping-math -ftree-ccp -ftree-ch -ftree-copy-prop
@ -ftree-copyrename -ftree-cselim -ftree-dce -ftree-dominator-opts
@ -ftree-dse -ftree-fre -ftree-loop-im -ftree-loop-ivcanon
@ -ftree-loop-optimize -ftree-parallelize-loops= -ftree-pre -ftree-reassoc
@ -ftree-salias -ftree-scev-cprop -ftree-sink -ftree-sra -ftree-store-ccp
@ -ftree-ter -ftree-vect-loop-version -ftree-vectorize -ftree-vrp
@ -funit-at-a-time -funswitch-loops -fverbose-asm -fzero-initialized-in-bss
@ -mglibc -mlittle-endian -msched-prolog -mthumb-interwork

@ Compiler executable checksum: d3429b3d44dc83ee8ef5b80b6a06f8ca

	.global	__aeabi_i2d
	.global	__aeabi_dcmpeq
	.global	__aeabi_i2f
	.global	__aeabi_f2d
	.global	__aeabi_ddiv
	.global	__aeabi_d2f
	.global	__aeabi_f2iz
	.global	__aeabi_dmul
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 64
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}	@,
	mov	r2, #0	@ tmp207,
	sub	sp, sp, #76	@,,
	mov	r3, #32768	@ tmp206,
	ldr	r0, .L9+8	@,
	str	r3, [sp, #68]	@ tmp206, x_i
	str	r2, [sp, #64]	@ tmp207, y_i
	str	r2, [sp, #60]	@ tmp207, z_i
	bl	puts	@
	ldr	r1, [sp, #68]	@ x_i.16, x_i
	mov	r3, #1069547520	@,
	mov	r2, #0	@,
	add	r3, r3, #3145728	@,,
	ldr	r0, .L9+12	@,
	str	r1, [sp, #0]	@ x_i.16,
	bl	printf	@
	ldr	r1, [sp, #64]	@ y_i.17, y_i
	mov	r2, #0	@,
	mov	r3, #0	@,
	ldr	r0, .L9+16	@,
	str	r1, [sp, #0]	@ y_i.17,
	bl	printf	@
	ldr	r1, [sp, #60]	@ z_i.18, z_i
	mov	r2, #0	@,
	mov	r3, #0	@,
	ldr	r0, .L9+20	@,
	str	r1, [sp, #0]	@ z_i.18,
	bl	printf	@
	ldr	r0, [sp, #68]	@ x_i.20, x_i
	bl	__aeabi_i2d	@
	mov	r2, #0	@,
	mov	r3, #0	@,
	bl	__aeabi_dcmpeq	@
	cmp	r0, #0	@,
	movne	r2, #2130706432	@,
	addne	r2, r2, #12582912	@,,
	strne	r2, [sp, #8]	@ float	@, x_out
	bne	.L4	@,
	ldr	r0, [sp, #68]	@ x_i.21, x_i
	bl	__aeabi_i2f	@
	bl	__aeabi_f2d	@
	adr	r3, .L9	@,
	ldmia	r3, {r2-r3}	@,
	bl	__aeabi_ddiv	@
	bl	__aeabi_d2f	@
	str	r0, [sp, #8]	@ float	@, x_out
.L4:
	ldr	r2, [sp, #68]	@ x1, x_i
	ldr	r4, [sp, #64]	@ y1, y_i
	mov	r7, r4, asr #31	@ tmp223, y1,
	cmp	r4, #0	@ y1,
	orrne	r7, r7, #1	@,, sign.37, tmp223
	mul	r3, r7, r2	@ tmp225, sign.37, x1
	mla	r0, r7, r4, r2	@ x1.41, sign.37, y1, x1
	rsb	r4, r3, r4	@ y1.43, tmp225, y1
	subs	r3, r4, #0	@ tmp228, y1.43,
	movne	r3, #1	@ tmp228
	orr	r3, r3, r4, asr #31	@,, tmp228, y1.43,
	str	r3, [sp, #12]	@, sign.48
	ldr	r1, [sp, #12]	@ tmp232, sign.48
	mov	r3, r0, asr #1	@ tmp231, x1.41,
	mul	r1, r3, r1	@ tmp232, tmp231, tmp232
	ldr	ip, [sp, #12]	@ x1.51, sign.48
	mov	r2, r4, asr #1	@ tmp229, y1.43,
	mla	ip, r2, ip, r0	@ x1.51, tmp229, x1.51, x1.41
	rsb	r4, r1, r4	@ y1.54, tmp232, y1.43
	subs	r3, r4, #0	@ tmp235, y1.54,
	movne	r3, #1	@ tmp235
	orr	r3, r3, r4, asr #31	@,, tmp235, y1.54,
	str	r3, [sp, #16]	@, sign.61
	ldr	r1, [sp, #16]	@ tmp239, sign.61
	mov	r3, ip, asr #2	@ tmp238, x1.51,
	mul	r1, r3, r1	@ tmp239, tmp238, tmp239
	ldr	r0, [sp, #16]	@ x1.64, sign.61
	mov	r2, r4, asr #2	@ tmp236, y1.54,
	mla	r0, r2, r0, ip	@ x1.64, tmp236, x1.64, x1.51
	rsb	r4, r1, r4	@ y1.67, tmp239, y1.54
	subs	r3, r4, #0	@ tmp242, y1.67,
	movne	r3, #1	@ tmp242
	orr	r3, r3, r4, asr #31	@,, tmp242, y1.67,
	str	r3, [sp, #20]	@, sign.74
	ldr	r1, [sp, #20]	@ tmp246, sign.74
	mov	r3, r0, asr #3	@ tmp245, x1.64,
	mul	r1, r3, r1	@ tmp246, tmp245, tmp246
	ldr	ip, [sp, #20]	@ x1.77, sign.74
	mov	r2, r4, asr #3	@ tmp243, y1.67,
	mla	ip, r2, ip, r0	@ x1.77, tmp243, x1.77, x1.64
	rsb	r4, r1, r4	@ y1.80, tmp246, y1.67
	subs	r3, r4, #0	@ tmp249, y1.80,
	movne	r3, #1	@ tmp249
	orr	r3, r3, r4, asr #31	@,, tmp249, y1.80,
	str	r3, [sp, #24]	@, sign.87
	ldr	r1, [sp, #24]	@ tmp253, sign.87
	mov	r3, ip, asr #4	@ tmp252, x1.77,
	mul	r1, r3, r1	@ tmp253, tmp252, tmp253
	ldr	r0, [sp, #24]	@ x1.90, sign.87
	mov	r2, r4, asr #4	@ tmp250, y1.80,
	mla	r0, r2, r0, ip	@ x1.90, tmp250, x1.90, x1.77
	rsb	r4, r1, r4	@ y1.93, tmp253, y1.80
	subs	r3, r4, #0	@ tmp256, y1.93,
	movne	r3, #1	@ tmp256
	orr	r3, r3, r4, asr #31	@,, tmp256, y1.93,
	str	r3, [sp, #28]	@, sign.100
	ldr	r1, [sp, #28]	@ tmp260, sign.100
	mov	r3, r0, asr #5	@ tmp259, x1.90,
	mul	r1, r3, r1	@ tmp260, tmp259, tmp260
	ldr	ip, [sp, #28]	@ x1.103, sign.100
	mov	r2, r4, asr #5	@ tmp257, y1.93,
	mla	ip, r2, ip, r0	@ x1.103, tmp257, x1.103, x1.90
	rsb	r4, r1, r4	@ y1.106, tmp260, y1.93
	subs	r3, r4, #0	@ tmp263, y1.106,
	movne	r3, #1	@ tmp263
	orr	r3, r3, r4, asr #31	@,, tmp263, y1.106,
	str	r3, [sp, #32]	@, sign.113
	ldr	r1, [sp, #32]	@ tmp267, sign.113
	mov	r3, ip, asr #6	@ tmp266, x1.103,
	mul	r1, r3, r1	@ tmp267, tmp266, tmp267
	ldr	r0, [sp, #32]	@ x1.116, sign.113
	mov	r2, r4, asr #6	@ tmp264, y1.106,
	mla	r0, r2, r0, ip	@ x1.116, tmp264, x1.116, x1.103
	rsb	r4, r1, r4	@ y1.119, tmp267, y1.106
	subs	r3, r4, #0	@ tmp270, y1.119,
	movne	r3, #1	@ tmp270
	orr	r3, r3, r4, asr #31	@,, tmp270, y1.119,
	str	r3, [sp, #36]	@, sign.126
	ldr	r1, [sp, #36]	@ tmp274, sign.126
	mov	r3, r0, asr #7	@ tmp273, x1.116,
	mul	r1, r3, r1	@ tmp274, tmp273, tmp274
	ldr	ip, [sp, #36]	@ x1.129, sign.126
	mov	r2, r4, asr #7	@ tmp271, y1.119,
	mla	ip, r2, ip, r0	@ x1.129, tmp271, x1.129, x1.116
	rsb	r4, r1, r4	@ y1.132, tmp274, y1.119
	subs	r3, r4, #0	@ tmp277, y1.132,
	movne	r3, #1	@ tmp277
	orr	r3, r3, r4, asr #31	@,, tmp277, y1.132,
	str	r3, [sp, #40]	@, sign.139
	ldr	r1, [sp, #40]	@ tmp281, sign.139
	mov	r3, ip, asr #8	@ tmp280, x1.129,
	mul	r1, r3, r1	@ tmp281, tmp280, tmp281
	ldr	r0, [sp, #40]	@ x1.142, sign.139
	mov	r2, r4, asr #8	@ tmp278, y1.132,
	mla	r0, r2, r0, ip	@ x1.142, tmp278, x1.142, x1.129
	rsb	r4, r1, r4	@ y1.145, tmp281, y1.132
	subs	r3, r4, #0	@ tmp284, y1.145,
	movne	r3, #1	@ tmp284
	orr	r3, r3, r4, asr #31	@,, tmp284, y1.145,
	str	r3, [sp, #44]	@, sign.152
	ldr	r1, [sp, #44]	@ tmp288, sign.152
	mov	r3, r0, asr #9	@ tmp287, x1.142,
	mul	r1, r3, r1	@ tmp288, tmp287, tmp288
	ldr	ip, [sp, #44]	@ x1.155, sign.152
	mov	r2, r4, asr #9	@ tmp285, y1.145,
	mla	ip, r2, ip, r0	@ x1.155, tmp285, x1.155, x1.142
	rsb	r4, r1, r4	@ y1.158, tmp288, y1.145
	subs	r3, r4, #0	@ tmp291, y1.158,
	movne	r3, #1	@ tmp291
	orr	r3, r3, r4, asr #31	@,, tmp291, y1.158,
	str	r3, [sp, #48]	@, sign.165
	ldr	r1, [sp, #48]	@ tmp295, sign.165
	mov	r3, ip, asr #10	@ tmp294, x1.155,
	mul	r1, r3, r1	@ tmp295, tmp294, tmp295
	ldr	r0, [sp, #48]	@ x1.168, sign.165
	mov	r2, r4, asr #10	@ tmp292, y1.158,
	mla	r0, r2, r0, ip	@ x1.168, tmp292, x1.168, x1.155
	rsb	r4, r1, r4	@ y1.171, tmp295, y1.158
	subs	r3, r4, #0	@ tmp298, y1.171,
	movne	r3, #1	@ tmp298
	orr	fp, r3, r4, asr #31	@, sign.178, tmp298, y1.171,
	mov	r3, r0, asr #11	@ tmp301, x1.168,
	mul	r1, r3, fp	@ tmp302, tmp301, sign.178
	mov	r2, r4, asr #11	@ tmp299, y1.171,
	mla	ip, r2, fp, r0	@ x1.181, tmp299, sign.178, x1.168
	rsb	r4, r1, r4	@ y1.184, tmp302, y1.171
	subs	r8, r4, #0	@ tmp305, y1.184,
	movne	r8, #1	@ tmp305
	orr	r8, r8, r4, asr #31	@, sign.191, tmp305, y1.184,
	mov	r3, ip, asr #12	@ tmp308, x1.181,
	mul	r1, r3, r8	@ tmp309, tmp308, sign.191
	mov	r2, r4, asr #12	@ tmp306, y1.184,
	mla	r0, r2, r8, ip	@ x1.194, tmp306, sign.191, x1.181
	rsb	r4, r1, r4	@ y1.197, tmp309, y1.184
	subs	sl, r4, #0	@ tmp312, y1.197,
	movne	sl, #1	@ tmp312
	orr	sl, sl, r4, asr #31	@, sign.204, tmp312, y1.197,
	mov	r3, r0, asr #13	@ tmp315, x1.194,
	mul	r1, r3, sl	@ tmp316, tmp315, sign.204
	mov	r2, r4, asr #13	@ tmp313, y1.197,
	mla	ip, r2, sl, r0	@ x1.207, tmp313, sign.204, x1.194
	rsb	r4, r1, r4	@ y1.210, tmp316, y1.197
	subs	r9, r4, #0	@ tmp319, y1.210,
	movne	r9, #1	@ tmp319
	orr	r9, r9, r4, asr #31	@, sign.217, tmp319, y1.210,
	mov	r3, ip, asr #14	@ tmp322, x1.207,
	mul	r2, r3, r9	@ tmp323, tmp322, sign.217
	mov	r3, r4, asr #14	@ tmp320, y1.210,
	mla	ip, r3, r9, ip	@ x1.207, tmp320, sign.217, x1.207
	ldr	r5, .L9+24	@ tmp324,
	ldr	r0, [r5, #0]	@ float	@, z_table
	rsb	r4, r2, r4	@ y1.223, tmp323, y1.210
	str	ip, [sp, #52]	@ x1.207, x1.220
	bl	__aeabi_f2iz	@
	mul	r6, r0, r7	@ tmp326,, sign.37
	ldr	r0, [r5, #4]	@ float	@, z_table
	bl	__aeabi_f2iz	@
	ldr	r7, [sp, #12]	@ z1.56, sign.48
	mla	r7, r0, r7, r6	@ z1.56,, z1.56, tmp326
	ldr	r0, [r5, #8]	@ float	@, z_table
	bl	__aeabi_f2iz	@
	ldr	r6, [sp, #16]	@ z1.69, sign.61
	mla	r6, r0, r6, r7	@ z1.69,, z1.69, z1.56
	ldr	r0, [r5, #12]	@ float	@, z_table
	bl	__aeabi_f2iz	@
	ldr	r7, [sp, #20]	@ z1.82, sign.74
	mla	r7, r0, r7, r6	@ z1.82,, z1.82, z1.69
	ldr	r0, [r5, #16]	@ float	@, z_table
	bl	__aeabi_f2iz	@
	ldr	r6, [sp, #24]	@ z1.95, sign.87
	mla	r6, r0, r6, r7	@ z1.95,, z1.95, z1.82
	ldr	r0, [r5, #20]	@ float	@, z_table
	bl	__aeabi_f2iz	@
	ldr	r7, [sp, #28]	@ z1.108, sign.100
	mla	r7, r0, r7, r6	@ z1.108,, z1.108, z1.95
	ldr	r0, [r5, #24]	@ float	@, z_table
	bl	__aeabi_f2iz	@
	ldr	r6, [sp, #32]	@ z1.121, sign.113
	mla	r6, r0, r6, r7	@ z1.121,, z1.121, z1.108
	ldr	r0, [r5, #28]	@ float	@, z_table
	bl	__aeabi_f2iz	@
	ldr	r7, [sp, #36]	@ z1.134, sign.126
	mla	r7, r0, r7, r6	@ z1.134,, z1.134, z1.121
	ldr	r0, [r5, #32]	@ float	@, z_table
	bl	__aeabi_f2iz	@
	ldr	r6, [sp, #40]	@ z1.147, sign.139
	mla	r6, r0, r6, r7	@ z1.147,, z1.147, z1.134
	ldr	r0, [r5, #36]	@ float	@, z_table
	bl	__aeabi_f2iz	@
	ldr	r7, [sp, #44]	@ z1.160, sign.152
	mla	r7, r0, r7, r6	@ z1.160,, z1.160, z1.147
	ldr	r0, [r5, #40]	@ float	@, z_table
	bl	__aeabi_f2iz	@
	ldr	r6, [sp, #48]	@ z1.173, sign.165
	mla	r6, r0, r6, r7	@ z1.173,, z1.173, z1.160
	ldr	r0, [r5, #44]	@ float	@, z_table
	bl	__aeabi_f2iz	@
	mla	r7, r0, fp, r6	@ z1.186,, sign.178, z1.173
	ldr	r0, [r5, #48]	@ float	@, z_table
	bl	__aeabi_f2iz	@
	mla	r6, r0, r8, r7	@ z1.199,, sign.191, z1.186
	ldr	r0, [r5, #52]	@ float	@, z_table
	bl	__aeabi_f2iz	@
	mla	r8, r0, sl, r6	@ z1.212,, sign.204, z1.199
	ldr	r0, [r5, #56]	@ float	@, z_table
	bl	__aeabi_f2iz	@
	ldr	r2, [sp, #52]	@, x1.220
	subs	r6, r4, #0	@ tmp371, y1.223,
	movne	r6, #1	@ tmp371
	orr	r6, r6, r4, asr #31	@, sign, tmp371, y1.223,
	mov	r3, r2, asr #15	@ tmp374,,
	mul	r2, r3, r6	@ tmp375, tmp374, sign
	mla	r7, r0, r9, r8	@ z1.225,, sign.217, z1.212
	ldr	r0, [r5, #60]	@ float	@, z_table
	ldr	r5, [sp, #52]	@ x1.35, x1.220
	mov	r3, r4, asr #15	@ tmp372, y1.223,
	mla	r5, r3, r6, r5	@ x1.35, tmp372, sign, x1.35
	rsb	r4, r2, r4	@ y1.36, tmp375, y1.223
	bl	__aeabi_f2iz	@
	mla	r3, r0, r6, r7	@ z1,, sign, z1.225
	ldr	r0, .L9+28	@,
	str	r5, [sp, #68]	@ x1.35, x_i
	str	r4, [sp, #64]	@ y1.36, y_i
	str	r3, [sp, #60]	@ z1, z_i
	bl	puts	@
	ldr	r0, [sp, #8]	@ float	@, x_out
	bl	__aeabi_f2d	@
	mov	r2, #0	@,
	mov	r3, #1056964608	@,
	bl	__aeabi_dmul	@
	b	.L10	@
.L11:
	.align	3
.L9:
	.word	-1257538936
	.word	1087598237
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LANCHOR0
	.word	.LC4
.L10:
	adr	r3, .L12	@,
	ldmia	r3, {r2-r3}	@,
	bl	__aeabi_ddiv	@
	mov	r2, r0	@ tmp385,
	mov	r3, r1	@,
	ldr	r0, .L12+8	@,
	bl	printf	@
	ldr	r0, [sp, #60]	@ z_i.22, z_i
	bl	__aeabi_i2d	@
	mov	r2, #0	@,
	mov	r3, #1056964608	@,
	bl	__aeabi_dmul	@
	mov	r2, r0	@ tmp389,
	mov	r3, r1	@,
	ldr	r0, .L12+12	@,
	bl	printf	@
	mov	r0, #0	@,
	add	sp, sp, #76	@,,
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, lr}
	bx	lr
.L13:
	.align	3
.L12:
	.word	1221297670
	.word	1073371425
	.word	.LC5
	.word	.LC6
	.size	main, .-main
	.global	z_table
	.data
	.align	2
.LANCHOR0 = . + 0
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
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Debug prints:\012\000"
	.space	1
.LC1:
	.ascii	"64-bit float x_d = %f\011\011\01116-bit int x_i = %"
	.ascii	"i\012\000"
	.space	3
.LC2:
	.ascii	"64-bit float y_d = %f\011\011\01116-bit int y_i = %"
	.ascii	"i\012\000"
	.space	3
.LC3:
	.ascii	"64-bit float z_d = %f\011\011\01116-bit int z_i = %"
	.ascii	"i\012\000"
	.space	3
.LC4:
	.ascii	"\012\012Results of CORDIC_Vectoring:\012\000"
.LC5:
	.ascii	"Scaled magnitude result x_i = %.12f\012\000"
	.space	3
.LC6:
	.ascii	"Angle of vector result z_i = %.12f\012\000"
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
