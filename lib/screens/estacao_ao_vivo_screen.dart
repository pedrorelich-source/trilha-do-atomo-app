import 'dart:math';

import 'package:flutter/material.dart';

import '../models/leitura.dart';
import '../theme/app_theme.dart';

/// Estação Radiação Natural (proposta de IoT). Nesta Sprint as leituras são simuladas;
/// na exposição virão do detector Geiger-Müller conectado ao ESP32 via MQTT.
class EstacaoAoVivoScreen extends StatefulWidget {
  const EstacaoAoVivoScreen({super.key, this.aleatorio});

  /// Gerador de números injetável, para testes previsíveis.
  final Random? aleatorio;

  @override
  State<EstacaoAoVivoScreen> createState() => _EstacaoAoVivoScreenState();
}

class _EstacaoAoVivoScreenState extends State<EstacaoAoVivoScreen> {
  static const _maximoHistorico = 6;

  late final Random _aleatorio = widget.aleatorio ?? Random();
  final List<Leitura> _historico = [];

  @override
  void initState() {
    super.initState();
    _historico.add(_simularLeitura());
  }

  /// Valores na faixa típica de fundo natural (0,08 a 0,22 µSv/h), só para demonstração.
  Leitura _simularLeitura() =>
      Leitura(microSvH: 0.08 + _aleatorio.nextDouble() * 0.14, horario: DateTime.now());

  void _novaLeitura() {
    setState(() {
      _historico.insert(0, _simularLeitura());
      if (_historico.length > _maximoHistorico) _historico.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    final atual = _historico.first;
    final media = _historico.map((l) => l.microSvH).reduce((a, b) => a + b) / _historico.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Estação ao vivo')),
      body: ListView(
        padding: const EdgeInsets.all(AppEspacos.medio),
        children: [
          Container(
            padding: const EdgeInsets.all(AppEspacos.grande),
            decoration: BoxDecoration(color: AppCores.marinho, borderRadius: BorderRadius.circular(18)),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.sensors, color: AppCores.ambar),
                    SizedBox(width: AppEspacos.pequeno),
                    Text('Radiação natural agora', style: TextStyle(fontSize: 16, color: AppCores.textoClaro)),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  atual.valorFormatado,
                  style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: AppCores.creme),
                ),
                const SizedBox(height: AppEspacos.pequeno),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(color: AppCores.acerto, borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    atual.classificacao.rotulo,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Média das últimas ${_historico.length} leituras: ${media.toStringAsFixed(2).replaceAll('.', ',')} µSv/h',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: AppCores.textoClaro),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppEspacos.medio),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppEspacos.medio),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.lightbulb_outline, color: AppCores.ambarEscuro),
                  const SizedBox(width: 12),
                  Expanded(child: Text(atual.classificacao.explicacao, style: Theme.of(context).textTheme.bodyLarge)),
                ],
              ),
            ),
          ),
          FilledButton.icon(
            onPressed: _novaLeitura,
            icon: const Icon(Icons.refresh),
            label: const Text('Nova leitura'),
          ),
          const SizedBox(height: AppEspacos.grande),
          Text('Histórico', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppEspacos.pequeno),
          ..._historico.map(
            (l) => Card(
              child: ListTile(
                leading: const Icon(Icons.timeline, color: AppCores.marinho),
                title: Text(l.valorFormatado),
                subtitle: Text(l.classificacao.rotulo),
                trailing: Text(l.horaFormatada),
              ),
            ),
          ),
          const SizedBox(height: AppEspacos.medio),
          Text(
            'Dados simulados: protótipo da Estação Radiação Natural. Na exposição, as leituras virão '
            'de um detector Geiger-Müller ligado a um ESP32 (proposta de IoT do projeto). '
            'O kit é didático e não substitui instrumentos de proteção radiológica.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
