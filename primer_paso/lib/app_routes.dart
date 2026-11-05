import 'package:flutter/material.dart';

import 'auth_screen.dart';
import 'favoritos_screen.dart';
import 'home_screen.dart';
import 'onboarding_screen.dart';
import 'splash_screen.dart';
import 'vacante_detail_screen.dart';
import 'vacante_model.dart';
import 'vacantes_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const auth = '/auth';
  static const home = '/home';
  static const vacantes = '/vacantes';
  static const detalle = '/detalle';
  static const favoritos = '/favoritos';
}

/// Genera las rutas y pasa los argumentos a cada pantalla por constructor.
Route<dynamic> generarRuta(RouteSettings settings) {
  Widget pantalla;
  switch (settings.name) {
    case AppRoutes.onboarding:
      pantalla = const OnboardingScreen();
      break;
    case AppRoutes.auth:
      pantalla = const AuthScreen();
      break;
    case AppRoutes.home:
      pantalla = const HomeScreen();
      break;
    case AppRoutes.vacantes:
      // Argumento opcional: tipo con el que se abre el filtro.
      pantalla = VacantesScreen(
        tipoInicial: settings.arguments as TipoOportunidad?,
      );
      break;
    case AppRoutes.detalle:
      // Argumento obligatorio: la Vacante a mostrar.
      pantalla = VacanteDetailScreen(vacante: settings.arguments as Vacante);
      break;
    case AppRoutes.favoritos:
      pantalla = const FavoritosScreen();
      break;
    default:
      pantalla = const SplashScreen();
  }
  return MaterialPageRoute(builder: (_) => pantalla, settings: settings);
}
