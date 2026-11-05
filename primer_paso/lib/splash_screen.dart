import 'package:flutter/material.dart';

import 'app_bootstrap.dart';
import 'app_routes.dart';
import 'auth_repository.dart';
import 'core_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _decidirDestino();
  }

  Future<void> _decidirDestino() async {
    final pausa = Future.delayed(const Duration(seconds: 2));
    final haySesion = await AuthRepository().restaurarSesion();
    if (haySesion && mounted) {
      await cargarDatosIniciales(context);
    }
    await pausa;
    if (!mounted) return;
    Navigator.pushReplacementNamed(
      context,
      haySesion ? AppRoutes.home : AppRoutes.onboarding,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primario,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Asset propio declarado en pubspec.yaml (img/logo.png).
            Image.asset(
              'img/logo.png',
              width: 120,
              height: 120,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.trending_up,
                size: 96,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            const Text(
              'Primer Paso',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            const Text(
              'Tu primer empleo empieza aquí',
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
