@@ Subrutina Choco
@@ r0 - x
@@ r1 - y
@@ r2 - 
@@ Eata subrutina determina si el personaje choca con las paredes

push {lr}




pop {pc}


@@ Subrutina Animacion
@@ r0 - numero de nivel
@@ Se dibujan la animacion del movimiento del personaje 
@@

.global animacion

push {lr}

@@ Se dibuja el nivel 

@@ Se dibuja fondo del nivel

    mov r0,#0
    mov r1,#0
    mov r2,#1024
    mov r3,#768

    bl DrawSquare

    cmp r0,#1
    beq nivel1 

    cmp r0,#2
    beq nivel2

bne menu

@@ NIVEL 1
nivel1:
    bl dibujarNivel1        // llamamos a la subrutina dibujarNivel1 que dibuja el nivel 1

@@ NIVEL  2
nivel2:
    bl dibujarNivel2        // llamamos a la subrutina dibujarNivel2 que dibuja el nivel 2

@@ Condiciones Iniciales
    ldr r9,=555
    mov r10,#33
    pasoActual .req r4
    mov pasoActual, #0

@@ Dibujar el personaje
    ldr r0, =pAltura
    bl drawImageWithTransparency // llamamos a la subrutina

loop:

@@ Revisamos las entradas del teclado

    bl KeyboardUpdate
    bl KeyboardGetChar

    @@ Salir
    teq r0,#'x'
    teqne r0,#'F'
    beq finA

@@ Abajo

    teq r0,#'s'
    teqne r0,#'S'
    addeq r10,#10
    beq movAbajo


@@ Arriba

    teq r0,#'w'
    teqne r0,#'W'
    subeq r10,#10
    beq movArriba

@@ Derecha

    teq r0,#'d'
    teqne r0,#'D'
    addeq r9,#10
    beq movDerecha

@@ Izquierda

    teq r0,#'a'
    teqne r0,#'A'
    subeq r9,#10
    beq movizquierda


@@ Validando los movimientos

movAbajo:
    
    mov r0,r9
    mov r1,r10
    mov r2,nivel
    
    bl choque

    teq r0,#2
    subeq r10,#10
    beq gameOver
    
    teq r0,#1
    subeq r10,#10
    beq pasos
    
    teq r0,#0
    beq borrarAbajo
    
    b pasos
    
    
movArriba:
    
    mov r0,r9
    mov r1,r10
    mov r2,nivel
    
    bl choque
    
    teq r0,#2
    addeq r10,#10
    beq gameOver
    
    teq r0,#1
    addeq r10,#10
    beq pasos
    
    teq r0,#0
    beq borrarArriba
    
    b pasos
    
movDerecha:

    mov r0,r9
    mov r1,r10
    mov r2,nivel
    
    bl choque

    teq r0,#2
    subeq r9,#10
    beq gameOver
    
    teq r0,#1
    subeq r9,#10
    beq pasos
    
    teq r0,#0
    beq borrarDerecha

    b pasos
    
movIzquierda:

    mov r0,r9
    mov r1,r10
    mov r2,nivel
    
    bl choque

    teq r0,#2
    addeq r9,#10
    beq gameOver
    
    teq r0,#1
    addeq r9,#10
    beq pasos
    
    teq r0,#0
    beq borrarIzquierda

    b pasos
    
 @@ Redibujando al personaje @@
    
borrarIzquierda:
    
    push {r9}
    
    mov r6,r9
    add r6,#10
    ldr r0,=//FALTA COLOR
    
    bl SetForeColour
    
    mov r0,r6
    mov r1,r10
    mov r2,#100
    mov r3,#100
    
    bl DrawSquare
    
    pop {r9}
    
    ldr r0,=pAltura
    mov r1,r9
    mov r2,r10
    
    bl drawImageWithTransparency
    
    b winner
    
    b loop
    
borrarDerecha:
    
     push {r9}
    
    mov r6,r9
    add r6,#10
    ldr r0,=//FALTA COLOR
    
    bl SetForeColour
    
    mov r0,r6
    mov r1,r10
    mov r2,#100
    mov r3,#100
    
    bl DrawSquare
    
    pop {r9}
    
    ldr r0,=pAltura
    mov r1,r9
    mov r2,r10
    
    bl drawImageWithTransparency
    
    b winner
    
    b loop
    
borrarArriba:

     push {r9}
    
    mov r6,r9
    add r6,#10
    ldr r0,=//FALTA COLOR
    
    bl SetForeColour
    
    mov r0,r9
    mov r1,r6
    mov r2,#100
    mov r3,#100
    
    bl DrawSquare
    
    pop {r9}
    
    ldr r0,=pAltura
    mov r1,r9
    mov r2,r10
    
    bl drawImageWithTransparency
    
    b winner
    
    b loop
    
    
borrarAbajo:

    push {r9}
    
    mov r6,r9
    add r6,#10
    ldr r0,= //FALTA COLOR
    
    bl SetForeColour
    
    mov r0,r6
    mov r1,r10
    mov r2,#100
    mov r3,#100
    
    bl DrawSquare
    
    pop {r9}
    
    ldr r0,=pAltura
    mov r1,r9
    mov r2,r10
    
    bl drawImageWithTransparency
    
    b winner
    
    b loop
    



pop {pc}





@@ Se dibujan los niveles @@

.globl dibujarNivel1
dibujarNivel1:
    push {lr}
    ldr r0, =height1
    mov r1, #0
    mov r2, #0
    bl drawImageWithTransparency
    pop {pc}
    
.globl dibujarNivel12
dibujarNivel2:
    push {lr}
    ldr r0, =height2
    mov r1, #0
    mov r2, #0
    bl drawImageWithTransparency
    pop {pc}






@@ Dibujar Imagenes @@ 
// ******************************************
// Subrutina para dibujar una imagen. 
//    Utiliza DrawPixel y SetForeColour
//    Asume color transparente como 1
// * r0 direccion del personaje
//     * [r0+0] alto del personaje
//     * [r0+2] ancho del personaje
//     * [r0+4] primer pixel del personaje
// * r1 posicion x
// * r2 posicion y
// * No tiene salidas
// ******************************************
.globl drawImageWithTransparency
drawImageWithTransparency:
    
    addr        .req r4
    x           .req r5
    y           .req r6
    height      .req r7
    width       .req r8
    conth       .req r9
    contw       .req r10
    
    push {r4,r5,r6,r7,r8,r9,r10,lr}
    
    mov addr, r0
    mov x, r1
    mov y, r2
    mov conth, #0
    mov contw, #0

    ldrh height, [addr]
    add addr,#2
    ldrh width, [addr]
    add addr,#2
    
characterLoop$:
    ldrh r0, [addr]
    ldrh r1, =1     // validar transparencia
    cmp r0,r1
    beq noDraw$
    bl SetForeColour
    
    add r0, x, contw
    add r1, y, conth
    bl DrawPixel
noDraw$:
    add contw, #1
    cmp contw, width
    moveq contw, #0
    addeq conth, #1
    cmp conth, height
    popeq {r4,r5,r6,r7,r8,r9,r10,pc}
    add addr, #2
    b characterLoop$
    
    .unreq addr
    .unreq x
    .unreq y
    .unreq height
    .unreq width
    .unreq conth
    .unreq contw


