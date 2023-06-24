public class DetectorPadroes {
    private int[] vetorPadrao;
    private int[] vetorValores;

    // Construtor
    public DetectorPadroes(int[] vetorPadrao, int[] vetorValores) {
        if (vetorPadrao.length > vetorValores.length) {
            throw new IllegalArgumentException("Erro: O tamanho do vetor original é menor que o com os padrões a serem encontrados!");
        }

        this.vetorPadrao = vetorPadrao;
        this.vetorValores = vetorValores;
    }

    // Função que faz toda a verificação de padrões
    public int detectarPadroes() {
        int quantidade = 0;
        int tamanhoPadrao = vetorPadrao.length;
        int tamanhoValores = vetorValores.length;

        for (int i = 0; i <= tamanhoValores - tamanhoPadrao; i++) {
            int[] padraoAtual = new int[tamanhoPadrao];

            System.arraycopy(vetorValores, i, padraoAtual, 0, tamanhoPadrao);

            if (java.util.Arrays.equals(padraoAtual, vetorPadrao)) {
                quantidade++;
            }
            
        }

        return quantidade;
    }

    public static void main(String[] args) {
        int[] vetorPadrao = {3, 7};
        int[] vetorValores = {1, 5, 6, 3, 7, 9, 4, 3, 7};

        try {
            DetectorPadroes detector = new DetectorPadroes(vetorPadrao, vetorValores);
            int resultado = detector.detectarPadroes();

            System.out.println("\nQuantidade de padrões detectados: " + resultado);
        } catch (IllegalArgumentException e) {
            System.out.println(e.getMessage());
        }
    }
}