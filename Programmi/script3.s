.data 
ind_a:  .word 3 
ind_b:  .word 5 

.bss 
ind_c: .space 4 

.text 
.global main

main:   
        ldr r0, =ind_a
        ldr r1, =ind_b

        ldr r3, [r0]
        ldr r4, [r1]

        add r5, r3, r4

        ldr r2, =ind_c
        str r5, [r2]

        cmp r3, #0 @ r3 - 0 -> imposta flags su cpsr
        bgt positivo
        b negativo

positivo: 
        mov r6, #1
        b end

negativo: 
        mov r6, #2
        b end

end:   
        mov pc, lr @passa il controllo al sistema operativo

@ b: salto non condizionato
@ bXX: salto condizionato
@ operatori disponibili per salti condizionati: gt,lt,ge,le