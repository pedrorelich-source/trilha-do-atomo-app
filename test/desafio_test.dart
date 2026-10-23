import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trilha_do_atomo/data/dados_mock.dart';
import 'package:trilha_do_atomo/models/usuario.dart';
import 'package:trilha_do_atomo/screens/estacao_screen.dart';
import 'package:trilha_do_atomo/theme/app_theme.dart';

Usuario novoUsuario() => Usuario(
      nome: 'Ana Souza',
      email: 'ana@escola.com',
      perfil: Perfil.estudante,
      cidade: 'Iperó',
      receberNovidades: false,
    );

Future<void> tocar(WidgetTester tester, Finder alvo) async {
  // ListView só constrói o que está perto da tela: rola até o alvo existir.
  if (alvo.evaluate().isEmpty) {
    await tester.scrollUntilVisible(alvo, 200, scrollable: find.byType(Scrollable).first);
  }
  await tester.ensureVisible(alvo);
  await tester.pumpAndSettle();
  await tester.tap(alvo);
  await tester.pumpAndSettle();
}

void main() {
  final alimentos = estacoesMock.firstWhere((e) => e.id == 'alimentos'); // 2 mitos: 20 e 15 pontos

  testWidgets('responder atualiza placar e explicação e devolve o resultado à estação', (tester) async {
    final usuario = novoUsuario();
    await tester.pumpWidget(MaterialApp(
      theme: AppTheme.tema,
      home: EstacaoScreen(estacao: alimentos, usuario: usuario),
    ));

    await tocar(tester, find.text('Responder: Mito ou Verdade'));
    expect(find.text('Desafio 1 de 2'), findsOneWidget);
    expect(find.text('Pontos: 0'), findsOneWidget);

    // Acerta o primeiro (é mito): placar muda pelo setState.
    await tocar(tester, find.text('Mito'));
    expect(find.text('Você acertou! +20 pontos'), findsOneWidget);
    expect(find.text('Pontos: 20'), findsOneWidget);

    // Erra o segundo (também é mito).
    await tocar(tester, find.text('Próximo desafio'));
    expect(find.text('Desafio 2 de 2'), findsOneWidget);
    await tocar(tester, find.text('Verdade'));
    expect(find.text('Não foi dessa vez'), findsOneWidget);
    expect(find.text('Pontos: 20'), findsOneWidget);

    // Resultado no Dialog e volta para a estação.
    await tocar(tester, find.text('Ver resultado'));
    expect(find.text('Você acertou 1 de 2 e somou 20 pontos nesta estação.'), findsOneWidget);
    await tocar(tester, find.text('Voltar para a estação'));

    expect(find.text('Progresso salvo: +20 pontos no total.'), findsOneWidget);
    expect(find.text('Tentar de novo'), findsOneWidget);
    expect(usuario.pontos, 20);
    expect(usuario.estacoesConcluidas, contains('alimentos'));
  });

  group('Usuario.registrarResultado', () {
    test('refazer com nota menor não reduz nem soma pontos', () {
      final u = novoUsuario()
        ..registrarResultado('alimentos', const ResultadoDesafio(acertos: 2, total: 2, pontos: 35))
        ..registrarResultado('alimentos', const ResultadoDesafio(acertos: 1, total: 2, pontos: 20));
      expect(u.pontos, 35);
      expect(u.respostas, 4);
      expect(u.acertos, 3);
    });

    test('refazer com nota maior soma só a diferença', () {
      final u = novoUsuario()
        ..registrarResultado('alimentos', const ResultadoDesafio(acertos: 1, total: 2, pontos: 20))
        ..registrarResultado('alimentos', const ResultadoDesafio(acertos: 2, total: 2, pontos: 35));
      expect(u.pontos, 35);
    });

    test('nível do jogador segue a mesma regra do banco', () {
      final u = novoUsuario();
      expect(u.nivelJogador, 'Iniciante');
      u.registrarResultado('a', const ResultadoDesafio(acertos: 3, total: 3, pontos: 60));
      expect(u.nivelJogador, 'Explorador Nuclear');
      u.registrarResultado('b', const ResultadoDesafio(acertos: 4, total: 4, pontos: 90));
      expect(u.nivelJogador, 'Especialista do Átomo');
    });
  });
}
