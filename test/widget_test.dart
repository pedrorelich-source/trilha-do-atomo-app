import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trilha_do_atomo/main.dart';

Future<void> abrirCadastro(WidgetTester tester) async {
  await tester.pumpWidget(const TrilhaDoAtomoApp());
  await tester.tap(find.text('Começar a trilha'));
  await tester.pumpAndSettle();
}

Future<void> tocar(WidgetTester tester, Finder alvo) async {
  await tester.ensureVisible(alvo);
  await tester.pumpAndSettle();
  await tester.tap(alvo);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('boas-vindas leva ao cadastro e permite voltar', (tester) async {
    await abrirCadastro(tester);
    expect(find.text('Crie seu perfil'), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Começar a trilha'), findsOneWidget);
  });

  testWidgets('cadastro vazio mostra os erros de validação', (tester) async {
    await abrirCadastro(tester);

    await tocar(tester, find.text('Criar perfil e entrar'));

    expect(find.text('Corrija os campos destacados para continuar.'), findsOneWidget);
    expect(find.text('Informe seu nome.'), findsOneWidget);
    expect(find.text('Informe seu e-mail.'), findsOneWidget);
    expect(find.text('Escolha um perfil.'), findsOneWidget);
    expect(find.text('É preciso aceitar para continuar.'), findsOneWidget);
  });

  testWidgets('cadastro válido abre a trilha com o nome do usuário', (tester) async {
    await abrirCadastro(tester);

    await tester.enterText(find.widgetWithText(TextFormField, 'Nome'), 'Ana Souza');
    await tester.enterText(find.widgetWithText(TextFormField, 'E-mail'), 'ana@escola.com');
    await tester.enterText(find.widgetWithText(TextFormField, 'Cidade'), 'Iperó');
    await tocar(tester, find.text('Você é…'));
    await tocar(tester, find.text('Estudante').last);
    await tocar(tester, find.byType(Checkbox));
    await tocar(tester, find.text('Criar perfil e entrar'));

    expect(find.text('Olá, Ana!'), findsOneWidget);
    expect(find.text('Perfil criado! Boa trilha, Ana.'), findsOneWidget);
  });
}
