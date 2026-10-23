import 'package:flutter/material.dart';

/// Cadastro do participante (o formulário é implementado no próximo passo).
class CadastroScreen extends StatelessWidget {
  const CadastroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crie seu perfil')),
      body: const Center(child: Text('Formulário de cadastro')),
    );
  }
}
