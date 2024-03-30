.data
vect: .word 10, 20, 30, 40, 50

.text
.global main

@obiettivo: R5 = vect[3]
main:
    @prima variante
    @ LDR R0, =vect
    @ ADD R0, R0, #8
    @ LDR R5, [R0]

    @seconda variante
    @ LDR R5, [R0, #8]

    @somma degli elementi di vect
    LDR R0, =vect @R0=puntatore vect[i]
    MOV R1, #0 @R1=i (contatore)
    MOV R2, #0 @R2=sum (somma)

loop:
    LDR R5, [R0, R1, LSL #2] @R5=vect[i] <-> indirizzo = R0 + 4*i
    ADD R2, R2, R5 @sum=sum+R5
    ADD R1, R1, #1 @i=i+1
    CMP R1, #5 
    BLT loop @if (i<5)