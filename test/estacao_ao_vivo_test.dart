import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trilha_do_atomo/models/leitura.dart';
import 'package:trilha_do_atomo/screens/estacao_ao_vivo_screen.dart';
import 'package:trilha_do_atomo/theme/app_theme.dart';

void main() {
  group('Classificacao.de (mesmas faixas do .NET)', () {
    test('limite do fundo natural', () => expect(Classificacao.de(0.30), Classificacao.fundoNatural));
    test('acima do típico', () => expect(Classificacao.de(0.31), Classificacao.acimaDoTipico));
    test('limite do acima do típico', () => expect(Classificacao.de(1.00), Classificacao.acimaDoTipico));
    test('alerta', () => expect(Classificacao.de(1.01), Classificacao.alerta));
  });

  testWidgets('nova leitura atualiza a tela e o histórico', (tester) async {
    await tester.pumpWidget(MaterialApp(
      theme: AppTheme.tema,
      home: EstacaoAoVivoScreen(aleatorio: Random(42)),
    ));
    expect(find.text('Média das últimas 1 leituras: ${_media(tester)} µSv/h'), findsOneWidget);
    expect(find.byIcon(Icons.timeline), findsOneWidget);

    await tester.tap(find.text('Nova leitura'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Média das últimas 2 leituras'), findsOneWidget);
    expect(find.byIcon(Icons.timeline), findsNWidgets(2));
    expect(find.text('Fundo natural'), findsWidgets);
  });
}

String _media(WidgetTester tester) {
  final texto = tester.widgetList<Text>(find.byType(Text)).map((t) => t.data ?? '').firstWhere((d) => d.endsWith('µSv/h'));
  return texto.replaceAll(' µSv/h', '');
}
