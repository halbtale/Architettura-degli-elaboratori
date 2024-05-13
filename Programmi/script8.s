@ COPIA VETTORE
.data
.equ vect_input_size, 5

vect_input: .word 10, 20, 30, 40, 50

.bss
vect_output: .space vect_input_size * 4

.text
.global main

main:
    push {r0, r1, r2, lr}
    ldr r0, =vect_input
    ldr r1, =vect_output
    mov r2, #vect_input_size
    bl copy
    pop {r0, r1, r2, lr}
    mov pc, lr

@input: {r0=indirizzo vettore sorgente, r1=indirizzo vettore destrinazione, r2=lunghezza vettore}
copy:
    push {r0, r1, r2, r3, r4, r5}
    mov r3, #0 @vect offset
    lsl r5, r2, #2
copy_loop:
    ldrb r4, [r0, r3]
    strb r4, [r1, r3]
    add r3, r3, #1
    cmp r3, r5
    bne copy_loop
copy_end:
    pop {r0, r1, r2, r3, r4, r5}
    mov pc, lr

    