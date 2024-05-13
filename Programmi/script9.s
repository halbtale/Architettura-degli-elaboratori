.data
.equ vect_input_length, 6
vect_input: .byte 0, 10, 20, 30, 50, 120

.bss
vect_output: .space vect_input_length*4

.text
.global main

main:
    push {r0, r1, r2, lr}
    ldr r0, =vect_input
    ldr r1, =vect_output
    mov r2, #vect_input_length
    bl by2wo
    pop {r0, r1, r2, lr}
    mov pc, lr


@Input: {r0=vect_input, r1=vect_output, r2, vect_input_length}
by2wo:
    push {r3, r4}
    mov r3, #0 @r3=counter
by2wo_loop:
    ldrsb r4, [r0, r3]
    str r4, [r1, r3, lsl #2]
    add r3, r3, #1
    cmp r3, r2
    blt by2wo_loop
    pop {r3, r4}
    mov pc, lr