@DIRETTIVE: istruzioni per il compilatore (.data, .word, .bss, .global)

.data @ definisci i dati iniziali del programma
ind_a:  .word 3 @ metti il valore 3 in una word
ind_b:  .word 5 @ metti il valore 5 in una word

.bss 
ind_c: .space 4 @ allochi 4 byte = 1 word

.text @ dice al compilatore che ciò che segue è un programma
.global main

@ r0 indirizzo di A
@ r1 indirizzo di B
@ r2 indirizzo di C

@ ldr -> load
@ sdr -> store

main:   ldr r0, =ind_a @r0 contiene indirizzo A
        ldr r1, =ind_b @r1 contiene indirizzo B
        ldr r3, [r0] @ r3 contiene valore A
        ldr r4, [r1] @ r4 contiene valore B
        add r5, r3, r4 @ risultato r3+r4 va in r5
        ldr r2, =ind_c
        str r5, [r2] @ copia valore in r5 in memoria all'indirizzo indicato in r2

@ add, sub: aritmentico logiche
@ ldr, sdr: spostamento dati memoria-registri
@ mov: spostamento dati tra registri