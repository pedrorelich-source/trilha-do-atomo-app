enum Perfil {
  estudante('Estudante'),
  professor('Professor'),
  visitante('Visitante');

  const Perfil(this.rotulo);

  final String rotulo;
}

/// Resultado de uma rodada de desafios de uma estação.
class ResultadoDesafio {
  const ResultadoDesafio({required this.acertos, required this.total, required this.pontos});

  final int acertos;
  final int total;
  final int pontos;
}

/// Usuário da trilha. O progresso fica em memória nesta Sprint (dados mockados).
class Usuario {
  Usuario({
    required this.nome,
    required this.email,
    required this.perfil,
    required this.cidade,
    required this.receberNovidades,
  });

  final String nome;
  final String email;
  final Perfil perfil;
  final String cidade;
  final bool receberNovidades;

  int pontos = 0;
  int acertos = 0;
  int respostas = 0;

  /// Melhor pontuação obtida em cada estação (id da estação → pontos).
  final Map<String, int> melhorPontuacao = {};

  Set<String> get estacoesConcluidas => melhorPontuacao.keys.toSet();

  String get primeiroNome => nome.trim().split(' ').first;

  double get percentualAcerto => respostas == 0 ? 0 : acertos / respostas * 100;

  /// Mesma regra de nível usada pela function de ranking do banco Oracle.
  String get nivelJogador {
    if (pontos >= 150) return 'Especialista do Átomo';
    if (pontos >= 60) return 'Explorador Nuclear';
    return 'Iniciante';
  }

  /// Soma ao total só o que a nova rodada superar a melhor anterior da estação,
  /// para que refazer a mesma estação não infle a pontuação.
  void registrarResultado(String estacaoId, ResultadoDesafio resultado) {
    acertos += resultado.acertos;
    respostas += resultado.total;
    final anterior = melhorPontuacao[estacaoId] ?? 0;
    if (!melhorPontuacao.containsKey(estacaoId) || resultado.pontos > anterior) {
      pontos += resultado.pontos - anterior;
      melhorPontuacao[estacaoId] = resultado.pontos;
    }
  }
}
