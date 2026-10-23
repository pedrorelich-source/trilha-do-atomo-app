import 'package:flutter/material.dart';

import '../data/dados_mock.dart';
import '../models/usuario.dart';
import '../theme/app_theme.dart';
import 'boas_vindas_screen.dart';

/// Perfil do jogador: dados do cadastro, estatísticas e estações concluídas.
class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key, required this.usuario});

  final Usuario usuario;

  Future<void> _sair(BuildContext context) async {
    final confirmou = await showDialog<bool>(
      context: context,
      builder: (contexto) => AlertDialog(
        title: const Text('Sair da trilha?'),
        content: const Text('Nesta versão de demonstração o progresso fica só na memória e será perdido.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(contexto).pop(false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.of(contexto).pop(true), child: const Text('Sair')),
        ],
      ),
    );
    if (confirmou == true && context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const BoasVindasScreen()),
        (_) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final concluidas = estacoesMock.where((e) => usuario.estacoesConcluidas.contains(e.id)).toList();
    final iniciais = usuario.nome.trim().split(RegExp(r'\s+')).take(2).map((p) => p[0].toUpperCase()).join();

    return Scaffold(
      appBar: AppBar(title: const Text('Meu perfil')),
      body: ListView(
        padding: const EdgeInsets.all(AppEspacos.medio),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 34,
                backgroundColor: AppCores.marinho,
                child: Text(iniciais, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppCores.ambar)),
              ),
              const SizedBox(width: AppEspacos.medio),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(usuario.nome, style: Theme.of(context).textTheme.titleLarge),
                    Text('${usuario.perfil.rotulo} · ${usuario.cidade}', style: Theme.of(context).textTheme.bodyMedium),
                    Text(usuario.email, style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppEspacos.grande),
          Container(
            padding: const EdgeInsets.all(AppEspacos.medio),
            decoration: BoxDecoration(color: AppCores.marinho, borderRadius: BorderRadius.circular(18)),
            child: Row(
              children: [
                _Estatistica(valor: '${usuario.pontos}', rotulo: 'pontos'),
                _Estatistica(valor: '${usuario.percentualAcerto.round()}%', rotulo: 'de acerto'),
                _Estatistica(valor: '${concluidas.length}/${estacoesMock.length}', rotulo: 'estações'),
              ],
            ),
          ),
          const SizedBox(height: AppEspacos.pequeno),
          Card(
            child: ListTile(
              leading: const Icon(Icons.military_tech, color: AppCores.ambarEscuro),
              title: const Text('Nível'),
              subtitle: Text(usuario.nivelJogador),
            ),
          ),
          const SizedBox(height: AppEspacos.medio),
          Text('Estações concluídas', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: AppEspacos.pequeno),
          if (concluidas.isEmpty)
            const Card(
              child: ListTile(
                leading: Icon(Icons.explore_outlined),
                title: Text('Nenhuma ainda'),
                subtitle: Text('Escolha uma estação na trilha e responda ao desafio.'),
              ),
            )
          else
            ...concluidas.map(
              (e) => Card(
                child: ListTile(
                  leading: Icon(e.icone, color: AppCores.marinho),
                  title: Text(e.area),
                  subtitle: Text('Melhor marca: ${usuario.melhorPontuacao[e.id]} de ${e.pontosPossiveis} pontos'),
                  trailing: const Icon(Icons.check_circle, color: AppCores.acerto),
                ),
              ),
            ),
          const SizedBox(height: AppEspacos.grande),
          OutlinedButton.icon(
            onPressed: () => _sair(context),
            icon: const Icon(Icons.logout),
            label: const Text('Sair'),
          ),
        ],
      ),
    );
  }
}

class _Estatistica extends StatelessWidget {
  const _Estatistica({required this.valor, required this.rotulo});

  final String valor;
  final String rotulo;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(valor, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppCores.ambar)),
          Text(rotulo, style: const TextStyle(fontSize: 13, color: AppCores.textoClaro)),
        ],
      ),
    );
  }
}
