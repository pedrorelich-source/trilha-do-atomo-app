import 'package:flutter/material.dart';

import '../models/usuario.dart';

/// Tela principal da trilha (a grade de estações é implementada no próximo passo).
class TrilhaScreen extends StatefulWidget {
  const TrilhaScreen({super.key, required this.usuario});

  final Usuario usuario;

  @override
  State<TrilhaScreen> createState() => _TrilhaScreenState();
}

class _TrilhaScreenState extends State<TrilhaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Olá, ${widget.usuario.primeiroNome}!')),
      body: const Center(child: Text('Estações da trilha')),
    );
  }
}
