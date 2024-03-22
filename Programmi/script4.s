.text
.global main

main:
    mov r0, #0

loop:
    cmp r0, #100
    bge end
    add r0, r0, #1
    b loop @ in realtà non salva l'indirizzo del loop all'interno di b, ma solo l'offset

end:
    b end