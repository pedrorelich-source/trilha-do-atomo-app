import 'package:flutter/material.dart';

/// Desafio "Mito ou Verdade" de uma estação.
class Desafio {
  const Desafio({
    required this.afirmacao,
    required this.verdadeiro,
    required this.explicacao,
    required this.pontos,
  });

  final String afirmacao;

  /// true = a afirmação é verdade; false = é mito.
  final bool verdadeiro;
  final String explicacao;
  final int pontos;
}

/// Estação da trilha: uma área de aplicação da tecnologia nuclear.
class Estacao {
  const Estacao({
    required this.id,
    required this.area,
    required this.icone,
    required this.titulo,
    required this.resumo,
    required this.beneficio,
    required this.nivel,
    required this.fonte,
    required this.desafios,
  });

  final String id;
  final String area;
  final IconData icone;
  final String titulo;
  final String resumo;
  final String beneficio;

  /// 1 = básico, 2 = intermediário, 3 = avançado.
  final int nivel;
  final String fonte;
  final List<Desafio> desafios;

  String get nivelDescricao => switch (nivel) {
        1 => 'Básico',
        2 => 'Intermediário',
        _ => 'Avançado',
      };

  int get pontosPossiveis => desafios.fold(0, (soma, d) => soma + d.pontos);
}
