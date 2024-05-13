@programma che elimina vocali da una stringa

@ingresso:
@R0=indirizzo inizio stringa
@R1=lunghezza strin

@output:
@R0=puntatore all'inizio della stringa senza vocali
@R1=puntatore all'inizio della stringa con solo vocali rimosse

.data
codvoc:
    .byte 0x41, 0x45, 0x49, 0x4F, 0x55 @maiuscole
    .byte 0x61, 0x65, 0x69, 0x6F, 0x75 @minuscole
    .align 4
str1:
    .ascii "Quarantaquattro gatti in fila per tre con il resto di 2"
    .byte 0
    .align 4

.text
.global main

main:
    push {r0, lr}
    ldr r0, =str1
    bl strlen
    bl codfisc
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


@Parametro di ingresso R0=carattere da esaminare
@Parametro di uscita R0=0 vocale o 1 no
vocale:
    push {r1-r3} 
    ldr r1, =codvoc @punta ad array vocali
    mov r2, #0 @offset nell'array
    mov r3, #0 @registro di lavoro

vocale_ciclo:
    ldrb r3, [r1, r2]
    cmp r0, r3
    beq vocale_si
    add r2, r2, #1 @esamina vocale successiva
    cmp r2, #10 @controlla se array è finito
    blo vocale_ciclo
    b vocale_fine
vocale_si:
    mov r0, #0
vocale_fine:
    pop {r1-r3}
    mov pc, lr

@Input: {R0=indirizzo stringa, r1=lunghezza stringa}
@Output: {R0=indirizzo stringa generata, r1=indirizzo inzio vocali eliminate}
codfisc:
    push {fp, lr} @salva fp e lr precedenti
    mov fp, sp @aggiorna posizione fp
    push {r0-r7} @salva registri usati
    bic r1, r1, #3 @rendi lunghezza stringa multipla di 4 approssimando per difetto
    add r1, r1, #4 @prendi multiplo di 4 superiore
    sub sp, sp, r1 @alloca lo spazio sufficiente a contenere la stringa

    ldr r1, [fp, #-28] @prendi valore r1 di input (salvato nello stack) che contiene lunghezza stringa
    mov r2, #0         @lunghezza stringa senza vocali
    mov r3, #0         @offset del carattere nella stringa
    ldr r4, [fp, #-32] @prendi valore r0 di input (salvato nello stack) che conteiene indirizzo stringa
    mov r5, sp          

scan:
    ldrb r0, [r4, r3] @carica un carattere della stringa
    strb r0, [r5, r3] @salvalo nella memoria dinamica
    bl vocale         @controlla se e' una vocale
    cmp r0, #0
    addne r2, r2, #1  @no, aumenta lungehzza stringa senza vocali
    add r3, r3, #1    @aumenta offset per prossimo carattere
    cmp r1, r3        @stringa finita?
    bhi scan          @no, esamina carattere successivo

    ldr r1, [fp, #-32] @r1=punta stringa generata
    add r2, r1, r2     @r2=punta a stringa vocali
    mov r3, sp         @r3=punta a stringa in memoria dinamica
    mov r4, #0         @offset stringa nella stringa generata
    mov r5, #0         @offset stringa nella stringa vocali
    mov r6, #0         @offset stringa nella memoria dinamica
    ldr r7, [fp, #-28]

build:
    ldrb r0, [r3, r6] @carattere stringa in memoria dinamica
    bl vocale 
    cmp r0, #0
    ldrb r0, [r3, r6]
    strneb r0, [r1, r4]
    addne r4, r4, #1
    streqb r0, [r2, r5]
    addeq r5, r5, #1
    add r6, r6, #1
    cmp r7, r6 
    bhi build

fine:
    mov r0, r1
    mov r1, r2
    bic r7, r7, #3
    add r7, r7, #4
    add sp, sp, r7
    add sp, sp, #8
    pop {r2-r7}
    pop {fp, lr}
    mov pc, lr