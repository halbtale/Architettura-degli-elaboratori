@funzione iterativa per il calcolo di un fattoriale
.text
.main
    push {r0, lr}
    mov r0, #6 @calcolo 6!
    bl fact
    pop {r0, lr}
    mov pc, lr

@parametro ingresso R0: contiene n
@parametro uscita R0: contiene n! o 0 (se c'è overflow)
fact:
    cmp r0, #0 @r0=0?
    moveq r0, #1 @si -> 0! = 1
    moveq pc, lr @fine
    cmp r0, #12 @r0=12? 13! causa overflow
    bls do_it @non c'è overflow -> procedi
    mov r0, #0 @c'è overflow, imposta output a 0
    mov pc, lr @fine

do_it:
    push {r1} @salva registro usato
    mov r1, r0 @r1=n
ciclo:
    subs r1, r1, #1 @r1=n-1
    beq fine @se n==0, fine ciclo
    mul r0, r1, r0 @r0=n(n-1)
    b ciclo
fine:
    pop {r1} @ripristina registro usato
    mov pc, lr @fine subroutine