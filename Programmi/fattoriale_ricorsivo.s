@funzione ricorsiva per il calcolo di un fattoriale
.text
.main
    push {r0, lr}
    mov r0, #6 @calcolo 6!
    bl fact
    pop {r0, lr}
    mov pc, lr

@parametro ingresso R0: contiene n
@parametro uscita R0: contiene n! o 0 (se c'è overflow)
rfact:
    cmp r0, #12 @controlla se c'è overflow
    bls do_it_r @no overflow, procedi
    mov r0, #0  @c'è overflow, esci e metti 0
    mov pc, lr

do_it_r:
    cmp r0, #2
    bhi fa      @n>2, calcola fattoriale ricorsivamente
    cmp r0, #0  @altrimenti: caso base n==0 -> 0! = 1 altrimenti n! = n (n==1 o n==2)
    moveq r0, #1
    mov pc, lr

fa:
    push {r1, lr}
    mov r1, r0         @r1=n
    subs r0, r0, #1    @r0=n-1
    bl do_it_r         @r0=(n-1)!
    mul r0, r1, r0     @r0=(n-1)! * n
    pop {r1, pc}