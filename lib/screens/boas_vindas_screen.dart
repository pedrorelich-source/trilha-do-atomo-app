import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'cadastro_screen.dart';

/// Tela inicial: apresenta a proposta e leva ao cadastro.
class BoasVindasScreen extends StatelessWidget {
  const BoasVindasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppCores.marinho,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppEspacos.grande),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Image.asset('assets/images/logo_atomo.png', height: 150, semanticLabel: 'Logo de um átomo'),
              const SizedBox(height: AppEspacos.grande),
              const Text(
                'Trilha do Átomo',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800, color: AppCores.creme),
              ),
              const SizedBox(height: AppEspacos.pequeno),
              const Text(
                'A tecnologia nuclear está mais perto do que você imagina.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, height: 1.4, color: AppCores.textoClaro),
              ),
              const SizedBox(height: 32),
              const Row(
                children: [
                  _Destaque(icone: Icons.map_outlined, texto: '10 estações'),
                  SizedBox(width: AppEspacos.pequeno),
                  _Destaque(icone: Icons.quiz_outlined, texto: 'Mito ou Verdade'),
                  SizedBox(width: AppEspacos.pequeno),
                  _Destaque(icone: Icons.emoji_events_outlined, texto: 'Pontos e níveis'),
                ],
              ),
              const Spacer(),
              FilledButton(
                style: FilledButton.styleFrom(backgroundColor: AppCores.ambar, foregroundColor: AppCores.marinho),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CadastroScreen()),
                ),
                child: const Text('Começar a trilha'),
              ),
              const SizedBox(height: AppEspacos.medio),
              const Text(
                'Parceiro: Marinha do Brasil · CTMSP',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: AppCores.textoClaro),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Destaque extends StatelessWidget {
  const _Destaque({required this.icone, required this.texto});

  final IconData icone;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        decoration: BoxDecoration(
          color: AppCores.marinhoClaro,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icone, color: AppCores.ambar, size: 28),
            const SizedBox(height: 6),
            Text(
              texto,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppCores.creme),
            ),
          ],
        ),
      ),
    );
  }
}
