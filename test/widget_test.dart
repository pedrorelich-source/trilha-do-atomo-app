import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trilha_do_atomo/main.dart';

void main() {
  testWidgets('boas-vindas leva ao cadastro e permite voltar', (tester) async {
    await tester.pumpWidget(const TrilhaDoAtomoApp());
    expect(find.text('Trilha do Átomo'), findsOneWidget);

    await tester.tap(find.text('Começar a trilha'));
    await tester.pumpAndSettle();
    expect(find.text('Crie seu perfil'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Começar a trilha'), findsOneWidget);
  });
}
