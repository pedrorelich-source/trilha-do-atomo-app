import 'package:flutter/material.dart';

import '../models/estacao.dart';
import '../theme/app_theme.dart';

/// Cartão de uma estação na grade da trilha.
class EstacaoCard extends StatelessWidget {
  const EstacaoCard({
    super.key,
    required this.estacao,
    required this.concluida,
    required this.onTap,
  });

  final Estacao estacao;
  final bool concluida;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: concluida ? AppCores.marinho : AppCores.creme,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(estacao.icone, color: concluida ? AppCores.ambar : AppCores.marinho),
                  ),
                  const Spacer(),
                  if (concluida)
                    const Icon(Icons.check_circle, color: AppCores.acerto, semanticLabel: 'Estação concluída'),
                ],
              ),
              const Spacer(),
              Text(
                estacao.area,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                '${estacao.nivelDescricao} · ${estacao.desafios.length} desafio(s)',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
