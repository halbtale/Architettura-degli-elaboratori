@ scrivere programma che calcoli lunghezza di una stringa
.bss
lostack:
    .skip 2048 
miostack:
    .skip 4

.data
str1:
    .ascii "Questa stringa e' lunga 36 caratteri"
    .byte 0     @EOS (terminatore di stringa)
    .align 4    @garantisce che indirizzo successivo sia multiplo di 4


.text
.main
    ldr sp, =miostack
    push {r0, lr}
    ldr r0, =str1
    bl strlen
    pop {r0, lr}
    mov pc, lr

@Parametro di ingresso R0=puntatore alla stringa
@Parametro di uscita R1=lunghezza stringa
strlen:
    push {r2}   @salva R2 sullo stack
    mov r1, #0  @contatore lunghezza stringa
strlen_loop:
    ldrb r2, [r0, r1]
    cmp r2, #0
    addne r1, r1, #1
    bne loop
strnlen_fine:
    pop {r2}
    mov pc, lr