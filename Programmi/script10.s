.data
.equ n, 10

.text
.global main

main:
    push {r0, lr}
    mov r0, #n
    bl rfib
    pop {r0, pc}

@input: {r0=n}
@output: {r0=fib(n) o -1 se c'è overflow}
rfib:
    cmp R0, #42 
    movhi R0, #-1
    movhi PC, LR
    cmp r0, #2
    movlt pc, lr
    cmp r0, #0
    movlt r0, #-1
    movlt pc, lr
    push {lr, r1, r2}
    sub r1, r0, #1
    sub r2, r0, #2
    mov r0, r1
    bl rfib
    mov r1, r0
    mov r0, r2
    bl rfib
    mov r2, r0
    add r0, r1, r2
    pop {lr, r1, r2}
    mov pc, lr