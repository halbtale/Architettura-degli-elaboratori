.text
.global main

main:
    mov r0, #1
    mov r1, #2
    subS r2, r0, r1 @S: -> modifica bit di stato
