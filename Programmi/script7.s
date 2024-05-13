.data
input: .word 0x16300000

.text
.global _start
_start:
	ldr r0, =input
	ldr r0, [r0]
	bl brev
	b end

brev:
	push {r1-r5}
	mov r4, #0
	mov r1, #31
brev_loop:
	rsb r3, r1, #31
	mov r2, r0
	lsr r2, r2, r1
	and r2, r2, #1
	lsl r2, r2, r3
	add r4, r4, r2
	subs r1, r1, #1
	bne brev_loop
	mov r0, r4
	pop {r1-r5}
	mov pc, lr
end: 
	