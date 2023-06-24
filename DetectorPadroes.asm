.data
    vetorPadrao:         .word 1, 2
    vetorValores:        .word 1, 2, 3, 1, 2, 4, 1, 2
    tamanhoPadrao:    .word 2
    tamanhoValores:   .word 8
    quantidade:          .word 0


.text
.globl encontrarQuantidade
encontrarQuantidade:
    # Inicializando os registradores
    la $t0, vetorPadrao     # $t0 = endereço de vetorPadrao
    lw $t1, 0($t0)           # $t1 = vetorPadrao[0]
    lw $t2, 4($t0)           # $t2 = vetorPadrao[1]

    la $t0, vetorValores    # $t0 = endereço de vetorValores
    la $t3, quantidade       # $t3 = endereço de quantidade
    lw $t4, 0($t0)           # $t4 = vetorValores[0]
    lw $t5, 4($t0)           # $t5 = vetorValores[1]
    lw $t6, tamanhoPadrao   # $t6 = tamanhoPadrao
    lw $t7, tamanhoValores  # $t7 = tamanhoValores

    addi $t7, $t7, -1        # tamanhoValores - 1
    sub $t7, $t7, $t6        # tamanhoValores - tamanhoPadrao


loop:
    beq $t7, $zero, fim     # Se tamanhoValores - tamanhoPadrao == 0, sair do loop

    beq $t4, $t1, verificarProximoElemento
    j incrementar


verificarProximoElemento:
    beq $t5, $t2, encontrouCorrespondencia
    j incrementar


encontrouCorrespondencia:
    addi $t7, $t7, -1        # Decrementar o contador
    addi $t3, $t3, 1         # Incrementar a quantidade
    j incrementar


incrementar:
    addi $t0, $t0, 4         # Avançar para o próximo elemento de vetorValores
    lw $t4, 0($t0)           # $t4 = vetorValores[i]
    lw $t5, 4($t0)           # $t5 = vetorValores[i+1]
    j loop


fim:
    li $v0, 1                # Carregar o código do syscall para imprimir um inteiro
    move $a0, $t3            # Colocar a quantidade em $a0
    syscall                  # Imprimir a quantidade

    li $v0, 10               # Carregar o código do syscall para sair do programa
    syscall                  # Encerrar o programa