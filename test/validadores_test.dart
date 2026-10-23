import 'package:flutter_test/flutter_test.dart';

import 'package:trilha_do_atomo/utils/validadores.dart';

void main() {
  group('nome', () {
    test('aceita nome com acento', () => expect(Validadores.nome('Júlia Ramos'), isNull));
    test('recusa vazio', () => expect(Validadores.nome('  '), 'Informe seu nome.'));
    test('recusa curto', () => expect(Validadores.nome('Al'), isNotNull));
    test('recusa números', () => expect(Validadores.nome('Ana 2'), 'Use apenas letras no nome.'));
  });

  group('e-mail', () {
    test('aceita e-mail válido', () => expect(Validadores.email('ana.souza@escola.edu.br'), isNull));
    test('recusa sem arroba', () => expect(Validadores.email('ana.escola.com'), isNotNull));
    test('recusa sem domínio', () => expect(Validadores.email('ana@'), isNotNull));
  });

  group('cidade', () {
    test('aceita cidade', () => expect(Validadores.cidade('São Paulo'), isNull));
    test('recusa vazia', () => expect(Validadores.cidade(''), 'Informe sua cidade.'));
  });
}
