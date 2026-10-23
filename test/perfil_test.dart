import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trilha_do_atomo/models/usuario.dart';
import 'package:trilha_do_atomo/screens/trilha_screen.dart';
import 'package:trilha_do_atomo/theme/app_theme.dart';

Future<void> tocar(WidgetTester tester, Finder alvo) async {
  if (alvo.evaluate().isEmpty) {
    await tester.scrollUntilVisible(alvo, 200, scrollable: find.byType(Scrollable).last);
  }
  await tester.ensureVisible(alvo);
  await tester.pumpAndSettle();
  await tester.tap(alvo);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('perfil mostra o progresso e sair volta ao início após confirmar', (tester) async {
    final usuario = Usuario(
      nome: 'Júlia Ramos',
      email: 'julia@escola.com',
      perfil: Perfil.visitante,
      cidade: 'Iperó',
      receberNovidades: true,
    )..registrarResultado('alimentos', const ResultadoDesafio(acertos: 2, total: 2, pontos: 35));

    await tester.pumpWidget(MaterialApp(theme: AppTheme.tema, home: TrilhaScreen(usuario: usuario)));
    expect(find.text('35 pontos'), findsOneWidget);
    expect(find.text('1 de 10 estações concluídas'), findsOneWidget);

    await tocar(tester, find.byTooltip('Meu perfil'));
    expect(find.text('Júlia Ramos'), findsOneWidget);
    expect(find.text('JR'), findsOneWidget);
    expect(find.text('100%'), findsOneWidget);
    expect(find.text('Melhor marca: 35 de 35 pontos'), findsOneWidget);

    await tocar(tester, find.text('Sair'));
    expect(find.text('Sair da trilha?'), findsOneWidget);
    await tocar(tester, find.widgetWithText(TextButton, 'Sair'));
    expect(find.text('Começar a trilha'), findsOneWidget);
  });
}
