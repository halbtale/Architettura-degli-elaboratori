.data
vect: .word 0, 1, 2, 3, 6, 8, 13, 26, 63, 93, 136
.equ vect_length, 11

.text
.global main

main:
    push {lr, r0-r3}
    ldr r0, =vect
    mov r1, #0
    mov r2, #vect_length
    mov r3, #6
    bl BSearch
    nop
    pop {lr, r0-r3}
    mov pc, lr


@Input: {r0=vect*, r1=start_index, r2=end_index, r3=search_item}
@Output: {r0=index}
BSearch:
    push {r1-r5, lr}
    add r4, r1, r2           @r4=start+end
    lsr r4, r4, #1           @r4=(start+end)/2
    cmp r4, #0
    blt BSearch_not_found
    cmp r1, r2
    bgt BSearch_not_found
    ldr r5, [r0, r4, lsl #2] @r5=mid_element
    cmp r3, r5
    beq BSearch_found
    bgt BSearch_greater
    blt BSearch_minor
BSearch_greater:
    mov r1, r4 
    add r1, r1, #1
    bl BSearch
    b BSearch_end
BSearch_minor:
    mov r2, r4
    sub r2, r2, #1
    bl BSearch
    b BSearch_end
BSearch_found:
    mov r0, r4
    b BSearch_end
BSearch_not_found:
    mov r0, #-1
BSearch_end:
    pop {r1-r5, lr}
    mov pc, lr