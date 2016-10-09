@@ Gerardo Molina
@@ Diego Felix

.global main
.func main

main:

    @@ Se dibuja el fondo
    
    ldr r0,=//COLOR GRIS
    
    bl setForeColour
    
    mov r0,#0
    mov r1,#0
    mov r2,#1024
    mov r3,#768
    
    bl DrawSquare
    
loop1:

    bl Animacion

    b loop1

    
    