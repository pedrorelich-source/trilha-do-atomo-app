import 'package:flutter/material.dart';

import '../data/dados_mock.dart';
import '../models/estacao.dart';
import '../models/usuario.dart';
import '../theme/app_theme.dart';
import '../widgets/estacao_card.dart';
import 'estacao_screen.dart';
import 'perfil_screen.dart';

/// Tela principal: progresso do jogador e grade com as estações da trilha.
class TrilhaScreen extends StatefulWidget {
  const TrilhaScreen({super.key, required this.usuario});

  final Usuario usuario;

  @override
  State<TrilhaScreen> createState() => _TrilhaScreenState();
}

class _TrilhaScreenState extends State<TrilhaScreen> {
  Future<void> _abrirEstacao(Estacao estacao) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => EstacaoScreen(estacao: estacao, usuario: widget.usuario)),
    );
    // Ao voltar, o progresso pode ter mudado: redesenha a grade e o cartão de pontos.
    setState(() {});
  }

  void _abrirPerfil() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PerfilScreen(usuario: widget.usuario)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final usuario = widget.usuario;
    final concluidas = usuario.estacoesConcluidas.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Olá, ${usuario.primeiroNome}!'),
        actions: [
          IconButton(
            tooltip: 'Meu perfil',
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: _abrirPerfil,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppEspacos.medio),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _CardProgresso(
              pontos: usuario.pontos,
              nivel: usuario.nivelJogador,
              concluidas: concluidas,
              total: estacoesMock.length,
            ),
            const SizedBox(height: AppEspacos.medio),
            Text('Estações da trilha', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppEspacos.pequeno),
            Expanded(
              child: GridView.builder(
                itemCount: estacoesMock.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.05,
                ),
                itemBuilder: (context, indice) {
                  final estacao = estacoesMock[indice];
                  return EstacaoCard(
                    estacao: estacao,
                    concluida: usuario.estacoesConcluidas.contains(estacao.id),
                    onTap: () => _abrirEstacao(estacao),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardProgresso extends StatelessWidget {
  const _CardProgresso({
    required this.pontos,
    required this.nivel,
    required this.concluidas,
    required this.total,
  });

  final int pontos;
  final String nivel;
  final int concluidas;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppEspacos.medio),
      decoration: BoxDecoration(color: AppCores.marinho, borderRadius: BorderRadius.circular(18)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.emoji_events, color: AppCores.ambar),
              const SizedBox(width: AppEspacos.pequeno),
              Text(
                '$pontos pontos',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppCores.creme),
              ),
              const Spacer(),
              Text(nivel, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppCores.ambar)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: total == 0 ? 0 : concluidas / total,
              minHeight: 10,
              backgroundColor: AppCores.marinhoClaro,
              color: AppCores.ambar,
            ),
          ),
          const SizedBox(height: AppEspacos.pequeno),
          Text(
            '$concluidas de $total estações concluídas',
            style: const TextStyle(fontSize: 14, color: AppCores.textoClaro),
          ),
        ],
      ),
    );
  }
}
