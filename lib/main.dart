import 'package:flutter/material.dart';

import 'theme/app_theme.dart';

void main() {
  runApp(const TrilhaDoAtomoApp());
}

class TrilhaDoAtomoApp extends StatelessWidget {
  const TrilhaDoAtomoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trilha do Átomo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.tema,
      home: const Scaffold(
        body: Center(child: Text('Trilha do Átomo')),
      ),
    );
  }
}
