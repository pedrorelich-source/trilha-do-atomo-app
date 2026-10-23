/// Faixas didáticas usadas pela Estação Radiação Natural (as mesmas do serviço .NET
/// e da proposta de IoT). Não são limites regulatórios de proteção radiológica.
enum Classificacao {
  fundoNatural('Fundo natural', 'Valor típico da radiação natural do ambiente: solo, rochas, materiais de construção e raios cósmicos.'),
  acimaDoTipico('Acima do típico', 'Acima da faixa típica da exposição: a equipe confere o ambiente e o equipamento.'),
  alerta('Alerta', 'Fora da faixa esperada: a equipe técnica confere o equipamento antes de mostrar o valor ao público.');

  const Classificacao(this.rotulo, this.explicacao);

  final String rotulo;
  final String explicacao;

  static Classificacao de(double microSvH) {
    if (microSvH <= 0.30) return Classificacao.fundoNatural;
    if (microSvH <= 1.00) return Classificacao.acimaDoTipico;
    return Classificacao.alerta;
  }
}

/// Uma leitura da taxa de dose ambiente, em microsievert por hora.
class Leitura {
  const Leitura({required this.microSvH, required this.horario});

  final double microSvH;
  final DateTime horario;

  Classificacao get classificacao => Classificacao.de(microSvH);

  String get valorFormatado => '${microSvH.toStringAsFixed(2).replaceAll('.', ',')} µSv/h';

  String get horaFormatada =>
      '${horario.hour.toString().padLeft(2, '0')}:${horario.minute.toString().padLeft(2, '0')}:${horario.second.toString().padLeft(2, '0')}';
}
