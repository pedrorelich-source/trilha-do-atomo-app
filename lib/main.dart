import 'package:flutter/material.dart';

import 'screens/boas_vindas_screen.dart';
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
      home: const BoasVindasScreen(),
    );
  }
}
