.data
    vetorPadrao:         .word 3, 7
    vetorValores:        .word 1, 5, 6, 3, 7, 4, 3, 7
    tamanhoPadrao:    .word 2
    tamanhoValores:   .word 8
    quantidade:          .word 0


.text
.globl encontrarQuantidade
encontrarQuantidade:
    # Inicializando os registradores
    la $t0, vetorPadrao     # $t0 = endereço na memória do vetorPadrao
    lw $t1, 0($t0)           # $t1 = carrega o valor armazenado na memória - vetorPadrao[0]
    lw $t2, 4($t0)           # $t2 = carrega o valor armazenado na memória - vetorPadrao[1]

    la $t0, vetorValores    # $t0 = endereço na memória do vetorValores
    la $t3, quantidade       # $t3 = endereço na memória da quantidade
    lw $t4, 0($t0)           # $t4 = carrega o valor armazenado na memória - vetorValores[0]
    lw $t5, 4($t0)           # $t5 = carrega o valor armazenado na memória - vetorValores[1]
    lw $t6, tamanhoPadrao   # $t6 = carrega o valor armazenado na memória - tamanhoPadrao
    lw $t7, tamanhoValores  # $t7 = carrega o valor armazenado na memória - tamanhoValores

    addi $t7, $t7, -1        # Decrementando o valor da variável tamanhoValores e armazenando o resultado novamente em $t7
    sub $t7, $t7, $t6        # tamanhoValores - tamanhoPadrao (#atribui a t7 novamente)
    # Essa diferença é usada como condição de parada no loop


loop:
    beq $t7, $zero, fim  # Verifica se tamanhoValores - tamanhoPadrao é igual a zero
    # Continuará até que o valor de $t7 seja igual a zero, indicando que todas as posições do vetor foram verificadas

    beq $t4, $t1, verificarProximoElemento    # Compara o elemento do vetor de valores com o elemento do vetor de padrão
    # Se forem iguais, pula para "verificarProximoElemento"

    j incrementar     # Se os valores não forem iguais, pula para "incrementar"


verificarProximoElemento:
    beq $t5, $t2, encontrouCorrespondencia    # Compara o próximo elemento do vetor com o próximo do vetor de padrão
    # Se forem iguais, pula para "encontrouCorrespondencia"

    j incrementar     # Se os valores não forem iguais, pula para "incrementar"


encontrouCorrespondencia:
    addi $t7, $t7, -1        # Decrementar o contador
    # Subtrai 1 do valor do registrador $t7, que representa a diferença entre tamanhoValores e tamanhoPadrao
    # Isso ocorre porque uma correspondência parcial foi encontrada, então reduzimos o tamanho restante para verificar

    addi $t3, $t3, 1   # Adiciona 1 ao valor do registrador $t3, que armazena a quantidade de correspondências encontradas

    j incrementar
    # Após incrementar a quantidade e decrementar o contador, o fluxo segue para "incrementar"
    # Nessa etapa, avançamos para o próximo elemento do vetor de valores para continuar a verificação

incrementar:
    addi $t0, $t0, 4
    # Adiciona 4 ao valor do registrador $t0, que armazena o endereço do vetorValores
    # Isso move o ponteiro para o próximo elemento do vetor (por conta dos bytes)

    lw $t4, 0($t0)           # $t4 = vetorValores[i]
    # Carrega o valor do elemento atual do vetorValores para o registrador $t4
    # O deslocamento 0($t0) significa que estamos acessando o elemento atual do vetorValores

    lw $t5, 4($t0)           # $t5 = vetorValores[i+1]
    # Carrega o valor do próximo elemento do vetorValores para o registrador $t5
    # O deslocamento 4($t0) significa que estamos acessando o próximo elemento do vetorValores

    j loop
    # Após atualizar os registradores $t4 e $t5 com os próximos elemento do vetorValores,
    # o fluxo é mandado de volta para "loop" para continuar a verificação


fim:
    li $v0, 1    # Coloca o valor 1 no registrador $v0, que indica a chamada para imprimir um inteiro

    move $a0, $t3 
    # Move o valor do registrador $t3, que armazena a quantidade de correspondências encontradas,
    # para o registrador $a0, que é o registrador de argumento para a chamada do syscall

    syscall   # Realiza a chamada do syscall para imprimir o valor armazenado no registrador $a0

    li $v0, 10  # Coloca o valor 10 no registrador $v0, que indica a chamada do syscall para sair do programa

    syscall   # Realiza a chamada do syscall para encerrar o programa