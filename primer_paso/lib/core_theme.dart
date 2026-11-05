import 'package:flutter/material.dart';
import 'vacante_model.dart';

/// Paleta global de "Primer Paso" (ODS 8: trabajo decente).
class AppColors {
  static const Color primario = Color(0xFF224F7A);
  static const Color acento = Color(0xFFF2A265);
  static const Color fondo = Color(0xFFF3F6FA);
  static const Color superficie = Colors.white;
  static const Color textoPrincipal = Color(0xFF1F2933);
  static const Color textoSecundario = Color(0xFF7B8794);
  static const Color borde = Color(0xFFD5DEE8);
  static const Color favorito = Color(0xFFD32F2F);

  // Color por tipo de oportunidad.
  static const Color vacante = Color(0xFF224F7A);
  static const Color beca = Color(0xFF2E7D5B);
  static const Color practica = Color(0xFF8A5A14);

  static Color colorTipo(TipoOportunidad tipo) {
    switch (tipo) {
      case TipoOportunidad.vacante:
        return vacante;
      case TipoOportunidad.beca:
        return beca;
      case TipoOportunidad.practica:
        return practica;
    }
  }

  static IconData iconoTipo(TipoOportunidad tipo) {
    switch (tipo) {
      case TipoOportunidad.vacante:
        return Icons.work_outline;
      case TipoOportunidad.beca:
        return Icons.school_outlined;
      case TipoOportunidad.practica:
        return Icons.assignment_outlined;
    }
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
      backgroundColor: AppColors.primario,
      foregroundColor: Colors.white,
      elevation: 0,
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
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
  );
}
