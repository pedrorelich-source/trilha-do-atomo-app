import 'package:flutter/material.dart';

import '../models/estacao.dart';
import '../models/usuario.dart';
import '../theme/app_theme.dart';

/// Desafio "Mito ou Verdade" de uma estação.
/// Gerenciamento de estado com StatefulWidget + setState: desafio atual, resposta escolhida,
/// acertos e pontos da rodada mudam a cada toque e redesenham a tela.
class DesafioScreen extends StatefulWidget {
  const DesafioScreen({super.key, required this.estacao});

  final Estacao estacao;

  @override
  State<DesafioScreen> createState() => _DesafioScreenState();
}

class _DesafioScreenState extends State<DesafioScreen> {
  int _indice = 0;
  bool? _respostaEscolhida;
  int _acertos = 0;
  int _pontos = 0;

  Desafio get _atual => widget.estacao.desafios[_indice];
  bool get _respondido => _respostaEscolhida != null;
  bool get _acertou => _respostaEscolhida == _atual.verdadeiro;
  bool get _ultimo => _indice == widget.estacao.desafios.length - 1;

  void _responder(bool achaQueEVerdade) {
    if (_respondido) return;
    setState(() {
      _respostaEscolhida = achaQueEVerdade;
      if (_acertou) {
        _acertos++;
        _pontos += _atual.pontos;
      }
    });
  }

  void _avancar() {
    if (_ultimo) {
      _mostrarResultado();
      return;
    }
    setState(() {
      _indice++;
      _respostaEscolhida = null;
    });
  }

  Future<void> _mostrarResultado() async {
    final total = widget.estacao.desafios.length;
    final resultado = ResultadoDesafio(acertos: _acertos, total: total, pontos: _pontos);

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (contexto) => AlertDialog(
        icon: Icon(
          _acertos == total ? Icons.emoji_events : Icons.school_outlined,
          color: AppCores.ambarEscuro,
          size: 40,
        ),
        title: Text(_acertos == total ? 'Mandou bem!' : 'Boa tentativa!'),
        content: Text(
          'Você acertou $_acertos de $total e somou $_pontos pontos nesta estação.',
          textAlign: TextAlign.center,
        ),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(contexto).pop(),
            child: const Text('Voltar para a estação'),
          ),
        ],
      ),
    );

    // Devolve o resultado para a tela anterior (passagem de parâmetro na volta).
    if (mounted) Navigator.of(context).pop(resultado);
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.estacao.desafios.length;

    return Scaffold(
      appBar: AppBar(title: const Text('Mito ou Verdade')),
      body: Padding(
        padding: const EdgeInsets.all(AppEspacos.medio),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text('Desafio ${_indice + 1} de $total', style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                const Icon(Icons.stars, color: AppCores.ambarEscuro),
                const SizedBox(width: 4),
                Text('Pontos: $_pontos', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: AppEspacos.medio),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppEspacos.grande),
                        child: Column(
                          children: [
                            Icon(widget.estacao.icone, size: 40, color: AppCores.marinho),
                            const SizedBox(height: AppEspacos.medio),
                            Text(
                              '“${_atual.afirmacao}”',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20, height: 1.4, fontWeight: FontWeight.w700, color: AppCores.texto),
                            ),
                            const SizedBox(height: AppEspacos.pequeno),
                            Text('Vale ${_atual.pontos} pontos', style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: AppEspacos.medio),
                    if (_respondido) _Feedback(acertou: _acertou, pontos: _atual.pontos, explicacao: _atual.explicacao),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppEspacos.medio),
            if (!_respondido)
              Row(
                children: [
                  Expanded(
                    child: _BotaoResposta(
                      rotulo: 'Mito',
                      icone: Icons.close,
                      cor: AppCores.erro,
                      onPressed: () => _responder(false),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _BotaoResposta(
                      rotulo: 'Verdade',
                      icone: Icons.check,
                      cor: AppCores.acerto,
                      onPressed: () => _responder(true),
                    ),
                  ),
                ],
              )
            else
              FilledButton(
                onPressed: _avancar,
                child: Text(_ultimo ? 'Ver resultado' : 'Próximo desafio'),
              ),
          ],
        ),
      ),
    );
  }
}

class _BotaoResposta extends StatelessWidget {
  const _BotaoResposta({required this.rotulo, required this.icone, required this.cor, required this.onPressed});

  final String rotulo;
  final IconData icone;
  final Color cor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: FilledButton.styleFrom(backgroundColor: cor),
      onPressed: onPressed,
      icon: Icon(icone),
      label: Text(rotulo),
    );
  }
}

class _Feedback extends StatelessWidget {
  const _Feedback({required this.acertou, required this.pontos, required this.explicacao});

  final bool acertou;
  final int pontos;
  final String explicacao;

  @override
  Widget build(BuildContext context) {
    final cor = acertou ? AppCores.acerto : AppCores.erro;
    return Container(
      padding: const EdgeInsets.all(AppEspacos.medio),
      decoration: BoxDecoration(
        color: cor.withValues(alpha: 0.08),
        border: Border.all(color: cor, width: 1.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(acertou ? Icons.check_circle : Icons.cancel, color: cor),
              const SizedBox(width: AppEspacos.pequeno),
              Text(
                acertou ? 'Você acertou! +$pontos pontos' : 'Não foi dessa vez',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: cor),
              ),
            ],
          ),
          const SizedBox(height: AppEspacos.pequeno),
          Text(explicacao, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
