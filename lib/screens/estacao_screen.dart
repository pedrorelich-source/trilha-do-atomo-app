import 'package:flutter/material.dart';

import '../models/estacao.dart';
import '../models/usuario.dart';
import '../theme/app_theme.dart';

/// Detalhes de uma estação: conteúdo, benefício, fonte e acesso ao desafio.
class EstacaoScreen extends StatelessWidget {
  const EstacaoScreen({super.key, required this.estacao, required this.usuario});

  final Estacao estacao;
  final Usuario usuario;

  @override
  Widget build(BuildContext context) {
    final melhor = usuario.melhorPontuacao[estacao.id];

    return Scaffold(
      appBar: AppBar(title: Text(estacao.area)),
      body: ListView(
        padding: const EdgeInsets.all(AppEspacos.medio),
        children: [
          Container(
            padding: const EdgeInsets.all(AppEspacos.grande),
            decoration: BoxDecoration(color: AppCores.marinho, borderRadius: BorderRadius.circular(18)),
            child: Row(
              children: [
                Icon(estacao.icone, color: AppCores.ambar, size: 48),
                const SizedBox(width: AppEspacos.medio),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        estacao.titulo,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppCores.creme),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Nível ${estacao.nivelDescricao}',
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppCores.ambar),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppEspacos.medio),
          _Secao(icone: Icons.menu_book_outlined, titulo: 'O que é', texto: estacao.resumo),
          _Secao(icone: Icons.favorite_border, titulo: 'Como ajuda as pessoas', texto: estacao.beneficio),
          _Secao(icone: Icons.verified_outlined, titulo: 'Fonte', texto: estacao.fonte),
          const SizedBox(height: AppEspacos.pequeno),
          Row(
            children: [
              _Numero(valor: '${estacao.desafios.length}', rotulo: 'desafios'),
              const SizedBox(width: AppEspacos.pequeno),
              _Numero(valor: '${estacao.pontosPossiveis}', rotulo: 'pontos possíveis'),
              const SizedBox(width: AppEspacos.pequeno),
              _Numero(valor: melhor == null ? '–' : '$melhor', rotulo: 'sua melhor marca'),
            ],
          ),
          const SizedBox(height: AppEspacos.grande),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.quiz_outlined),
            label: Text(melhor == null ? 'Responder: Mito ou Verdade' : 'Tentar de novo'),
          ),
        ],
      ),
    );
  }
}

class _Secao extends StatelessWidget {
  const _Secao({required this.icone, required this.titulo, required this.texto});

  final IconData icone;
  final String titulo;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(AppEspacos.medio),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icone, color: AppCores.ambarEscuro),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(titulo, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(texto, style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Numero extends StatelessWidget {
  const _Numero({required this.valor, required this.rotulo});

  final String valor;
  final String rotulo;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: AppCores.cartao,
          border: Border.all(color: AppCores.borda),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(valor, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppCores.marinho)),
            Text(rotulo, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
