import 'package:flutter/material.dart';

import '../models/usuario.dart';
import '../theme/app_theme.dart';
import '../utils/validadores.dart';
import 'trilha_screen.dart';

/// Formulário de cadastro do participante, com validação dos campos.
class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cidadeController = TextEditingController();

  Perfil? _perfil;
  bool _receberNovidades = false;
  bool _aceitouTermos = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cidadeController.dispose();
    super.dispose();
  }

  void _enviar() {
    final mensageiro = ScaffoldMessenger.of(context);
    if (!_formKey.currentState!.validate()) {
      mensageiro.showSnackBar(
        const SnackBar(content: Text('Corrija os campos destacados para continuar.')),
      );
      return;
    }

    final usuario = Usuario(
      nome: _nomeController.text.trim(),
      email: _emailController.text.trim().toLowerCase(),
      perfil: _perfil!,
      cidade: _cidadeController.text.trim(),
      receberNovidades: _receberNovidades,
    );

    mensageiro.showSnackBar(
      SnackBar(
        backgroundColor: AppCores.acerto,
        content: Text('Perfil criado! Boa trilha, ${usuario.primeiroNome}.'),
      ),
    );
    // pushReplacement: depois do cadastro, "voltar" não deve reabrir o formulário.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => TrilhaScreen(usuario: usuario)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crie seu perfil')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppEspacos.grande),
          children: [
            Text('Conte um pouco sobre você', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: AppEspacos.pequeno),
            Text(
              'Usamos estes dados só para mostrar seu progresso na trilha.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppEspacos.grande),
            TextFormField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome', prefixIcon: Icon(Icons.person_outline)),
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              validator: Validadores.nome,
            ),
            const SizedBox(height: AppEspacos.medio),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-mail', prefixIcon: Icon(Icons.mail_outline)),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: Validadores.email,
            ),
            const SizedBox(height: AppEspacos.medio),
            TextFormField(
              controller: _cidadeController,
              decoration: const InputDecoration(labelText: 'Cidade', prefixIcon: Icon(Icons.location_city_outlined)),
              textCapitalization: TextCapitalization.words,
              validator: Validadores.cidade,
            ),
            const SizedBox(height: AppEspacos.medio),
            DropdownButtonFormField<Perfil>(
              initialValue: _perfil,
              decoration: const InputDecoration(labelText: 'Você é…', prefixIcon: Icon(Icons.badge_outlined)),
              items: Perfil.values
                  .map((p) => DropdownMenuItem(value: p, child: Text(p.rotulo)))
                  .toList(),
              onChanged: (p) => setState(() => _perfil = p),
              validator: (p) => p == null ? 'Escolha um perfil.' : null,
            ),
            const SizedBox(height: AppEspacos.pequeno),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Quero receber novidades da trilha'),
              value: _receberNovidades,
              onChanged: (valor) => setState(() => _receberNovidades = valor),
            ),
            FormField<bool>(
              initialValue: false,
              validator: (_) => _aceitouTermos ? null : 'É preciso aceitar para continuar.',
              builder: (campo) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('Concordo com o uso dos meus dados para registrar meu progresso (LGPD).'),
                    value: _aceitouTermos,
                    onChanged: (valor) {
                      setState(() => _aceitouTermos = valor ?? false);
                      campo.didChange(valor);
                    },
                  ),
                  if (campo.hasError)
                    Padding(
                      padding: const EdgeInsets.only(left: AppEspacos.medio),
                      child: Text(
                        campo.errorText!,
                        style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppEspacos.grande),
            FilledButton.icon(
              onPressed: _enviar,
              icon: const Icon(Icons.check),
              label: const Text('Criar perfil e entrar'),
            ),
          ],
        ),
      ),
    );
  }
}
