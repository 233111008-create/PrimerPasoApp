import 'package:flutter/material.dart';

class AppColors {
  static const Color primario = Color(0xFF183B5B);
  static const Color acento = Color(0xFFF28B68);
  static const Color fondo = Color(0xFFF5F7FB);
  static const Color superficie = Colors.white;
  static const Color textoPrincipal = Color(0xFF172B3A);
  static const Color textoSecundario = Color(0xFF738292);
  static const Color borde = Color(0xFFE2E8EF);
  static const Color favorito = Color(0xFFD32F2F);
  static const Color sombra = Color(0x14183B5B);


  static const Color vacante = Color(0xFF224F7A);
  static const Color beca = Color(0xFF2E7D5B);
  static const Color practica = Color(0xFF8A5A14);

  static Color colorTipo(String tipo) {
    if (tipo == 'Beca') return beca;
    if (tipo == 'Práctica') return practica;
    return vacante;
  }

  static IconData iconoTipo(String tipo) {
    if (tipo == 'Beca') return Icons.school_outlined;
    if (tipo == 'Práctica') return Icons.assignment_outlined;
    return Icons.work_outline;
  }
}

class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.fondo,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primario,
      primary: AppColors.primario,
      secondary: AppColors.acento,
      surface: AppColors.superficie,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.fondo,
      foregroundColor: AppColors.textoPrincipal,
      elevation: 0,
      scrolledUnderElevation: 1,
      surfaceTintColor: Colors.transparent,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textoPrincipal,
      ),
      titleMedium: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: AppColors.textoPrincipal,
      ),
      bodyMedium: TextStyle(fontSize: 15, color: AppColors.textoSecundario),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.borde),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.borde),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.primario, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.white,
      selectedColor: AppColors.primario,
      side: const BorderSide(color: AppColors.borde),
      labelStyle: const TextStyle(color: AppColors.primario),
      secondaryLabelStyle: const TextStyle(color: Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primario,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        elevation: 2,
        shadowColor: AppColors.sombra,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    ),
  );
}
