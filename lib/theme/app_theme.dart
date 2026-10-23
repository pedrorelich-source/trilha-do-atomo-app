import 'package:flutter/material.dart';

/// Paleta da Trilha do Átomo: azul-marinho (Marinha do Brasil) e âmbar (energia).
class AppCores {
  static const marinho = Color(0xFF0F2A44);
  static const marinhoClaro = Color(0xFF163A5C);
  static const ambar = Color(0xFFF2B54A);
  static const ambarEscuro = Color(0xFF9A5B0A);
  static const creme = Color(0xFFF6F4EE);
  static const cartao = Color(0xFFFFFDF8);
  static const borda = Color(0xFFE2DCCD);
  static const texto = Color(0xFF1E2A38);
  static const textoSuave = Color(0xFF4A5568);
  static const textoClaro = Color(0xFFC9D6E3);
  static const acerto = Color(0xFF2F855A);
  static const erro = Color(0xFFC53030);
}

/// Espaçamentos padronizados entre as telas.
class AppEspacos {
  static const pequeno = 8.0;
  static const medio = 16.0;
  static const grande = 24.0;
}

class AppTheme {
  static ThemeData get tema {
    final esquema = ColorScheme.fromSeed(
      seedColor: AppCores.marinho,
      primary: AppCores.marinho,
      secondary: AppCores.ambar,
      surface: AppCores.creme,
    );

    return ThemeData(
      colorScheme: esquema,
      scaffoldBackgroundColor: AppCores.creme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppCores.marinho,
        foregroundColor: AppCores.creme,
        titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppCores.creme),
      ),
      cardTheme: CardThemeData(
        color: AppCores.cartao,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppCores.borda),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppCores.marinho,
          foregroundColor: AppCores.creme,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppCores.marinho),
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppCores.marinho),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppCores.texto),
        bodyLarge: TextStyle(fontSize: 16, height: 1.4, color: AppCores.texto),
        bodyMedium: TextStyle(fontSize: 14, height: 1.4, color: AppCores.textoSuave),
      ),
    );
  }
}
