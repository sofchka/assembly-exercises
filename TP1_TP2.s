/*
.global _start
@ Exercice 1 {input - r1, r2}

_start:
	
	cmp   r1, r2
	movgt r3, r1
	movlt r3, r2
	movhi r4, r1
	movlo r4, r2

_end:
*/
/*
.global _start
@ Exercice 2 {input - r5, r6}

_start:

loop:
	cmp r6, #0
	beq fin
	mov r7, r5
loop2:
	cmp r7, r6
	blo fin2
	sub r7, r7, r6
	b loop2
fin2:
	mov r5, r6
	mov r6, r7
	b loop
fin:
	mov r8, r5
	

_end:
*/
/*
.global _start
@ Exercice 3 {input - r9}

_start:

mov r0, #0
loop:
	cmp r9, r0
	blo fin

si1:
	tst r9, #0b1
	bne suite
	add r10, r10, r9
	
si2:
	tst r9, #0b11
	bne suite
	add r11, r11, r9
	
si3:
	tst r9, #0b111
	bne suite
	add r12, r12, r9

suite:
	add r0, r0, #1
	b loop

fin:

_end:
*/
/*
.global _start
@ Exercice 3 VERSION 2

.equ N, 128

_start:

mov r0, #0
mov r1, #0
loop:
	cmp r0, #N
	bhi fin

	mov r1, r0
si1:
	movs r1, r1, lsr #1
	bcs suite
	add r10, r10, r0
	
	mov r1, r0
si2:
	movs r1, r1, lsr #1
	bcs suite
	movs r1, r1, lsr #1
	bcs suite
	add r11, r11, r0
	
	mov r1, r0
si3:
	movs r1, r1, lsr #1
	bcs suite
	movs r1, r1, lsr #1
	bcs suite
	movs r1, r1, lsr #1
	bcs suite
	add r12, r12, r0

suite:
	add r0, r0, #1
	b loop

fin:
*/
/*
.global _start
@ Exercice 4 {input - r1, r2}

_start:
	operateur: .byte '-'
	.align
	
	adr r5, operateur
	ldrb r4, [r5]
	cmp r4, #'+'
	addeq r3, r1, r2
	cmp r4, #'*'
	muleq r3, r1, r2
	cmp r4, #'-'
	subeq r3, r1, r2

_end:
*/
/*
.global _start
@ Exercice 5

tab: .int 9, -4, 27592, 0, -27592, 9, -4, 27592, 0, 8872

_start:

	adr r5, tab
	ldr r3, [r5] @ max init
	mov r1, #-1  @ max num index
	mov r2, #0   @ i

loop:
	cmp r2, #10
	bhs fin
	ldr r4, [r5], #4
	
si:
	cmp r4, r3
	movgt r3, r4 @ max num
	movgt r1, r2 @ max index 
	add r2, r2, #1
	b loop

fin:
	b fin @ to end
	
_end:
*/
/*
.global _start
@ Exercice 6

chaine: .asciz "#ABZ]aez}"
.align

_start:
	adr r5, chaine

loop:
	ldrb r4, [r5]
	cmp r4, #0
	beq fin
	
si:
	cmp r4, #'a'
	blo suite
	cmp r4, #'z'
	bhi suite
	sub r4, r4, #32

suite:
	strb r4, [r5], #1
	b loop
	
fin:
	b fin

_end:
*/

/*
.global _start
@ Exercice 7 - Byte Version

MAT: .byte 0, 1, 2, 3
     .byte 4, 5, 6, 7
.align

_start:
    mov r0, #1 @ row 
    mov r1, #2 @ column

    adr r2, MAT
    mov r3, #4 @ numb of columns
    mla r4, r0, r3, r1 @ i*4 + j
    mov r5, #0 @ value to store
    strb r5, [r2, r4]

fin:
    b fin
*/
/*
.global _start
@ Exercice 7 - Int Version

MAT: .int 0, 1, 2, 3
     .int 4, 5, 6, 7
.align

_start:
    mov r0, #1 @ row 
    mov r1, #2 @ column

    adr r2, MAT
    mov r3, #4 @ numb of columns
    mla r4, r0, r3, r1 @ i*4 + j
    mov r5, #0 @ value to store
    str r5, [r2, r4, lsl #2]

fin:
    b fin
*/
/*
.global _start
@ Exercice 8 (memmove)

.equ N, 32 @ r0
source: .fill 32, 1, 0x00 @ r1
destination: .fill 32, 1 @ r2

_start:
	adr r1, source
	adr r2, destination

	mov r0, #N
	
    cmp r0, #0
    beq fin

@ checking if we need to do backward copy or use forward copy
    cmp r2, r1
    bls forward @ dst <= src

    add r3, r1, r0 @ src + N
    cmp r2, r3
    bhs forward @ dst >= src+N

@ backward
    add r1, r1, r0
    add r2, r2, r0

back_loop:
    cmp r0, #0
    beq fin
    ldrb r3, [r1, #-1]!
    strb r3, [r2, #-1]!
    sub r0, r0, #1
    b back_loop

forward:
forw_loop:
    cmp r0, #0
    beq fin
    ldrb r3, [r1], #1
    strb r3, [r2], #1
    sub r0, r0, #1
    b forw_loop

fin:
    b fin
*/
/*
.global _start

@ Exercice 8 (memmove - words)

.equ N, 32 @ r0
source_opt: .word 0x00, 0x11, 0x22, 0x11, 0x00, 0x11, 0x22, 0x11 @ r1
destination_opt: .fill 32, 1 @ r2

_start:
	adr r1, source_opt
	adr r2, destination_opt

	mov r0, #N

	cmp r0, #0
    beq fin
	
@ checking if we need to do backward copy or use forward copy

    cmp r2, r1
    bls opt_forward

    add r3, r1, r0 @ r3 = src + N
    cmp r2, r3
    bhs opt_forward

@ opt_backward
    add r1, r1, r0
    add r2, r2, r0

back_words:
    cmp r0, #4
    blo back_half
    ldr r3, [r1, #-4]!
    str r3, [r2, #-4]!
    sub r0, r0, #4
    b back_words

back_half:
    cmp r0, #2
    blo back_byte
    ldrh r3, [r1, #-2]!
    strh r3, [r2, #-2]!
    sub r0, r0, #2

back_byte:
    cmp r0, #1
    blo fin
    ldrb r3, [r1, #-1]!
    strb r3, [r2, #-1]!
    sub r0, r0, #1
    b fin

opt_forward:

@ copy words
forw_words:
    cmp r0, #4
    blo forw_half
    ldr r3, [r1], #4
    str r3, [r2], #4
    sub r0, r0, #4
    b forw_words

forw_half:
    cmp r0, #2
    blo forw_byte
    ldrh r3, [r1], #2
    strh r3, [r2], #2
    sub r0, r0, #2

forw_byte:
    cmp r0, #1
    blo fin
    ldrb r3, [r1], #1
    strb r3, [r2], #1
    sub r0, r0, #1
    b fin

fin:
    b fin
*/