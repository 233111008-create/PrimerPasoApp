import 'package:flutter/material.dart';

import 'app_routes.dart';
import 'core_theme.dart';
import 'custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _PaginaOnboarding {
  final IconData icono;
  final String titulo;
  final String texto;
  const _PaginaOnboarding(this.icono, this.titulo, this.texto);
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _paginas = [
    _PaginaOnboarding(
      Icons.work_outline,
      'Encuentra tu primer empleo',
      'Explora vacantes, becas y prácticas pensadas para jóvenes.',
    ),
    _PaginaOnboarding(
      Icons.school_outlined,
      'Becas y capacitación',
      'Descubre apoyos para seguir estudiando y crecer profesionalmente.',
    ),
    _PaginaOnboarding(
      Icons.favorite_border,
      'Guarda lo que te interesa',
      'Marca tus favoritos y revisa los requisitos antes de postularte.',
    ),
  ];

  final PageController _controller = PageController();
  int _pagina = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _irAAuth() => Navigator.pushReplacementNamed(context, AppRoutes.auth);

  void _siguiente() {
    if (_pagina == _paginas.length - 1) {
      _irAAuth();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final esUltima = _pagina == _paginas.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _irAAuth,
                child: const Text('Saltar'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _paginas.length,
                onPageChanged: (i) => setState(() => _pagina = i),
                itemBuilder: (context, i) {
                  final p = _paginas[i];
                  return Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            color: AppColors.primario.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            p.icono,
                            size: 72,
                            color: AppColors.primario,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        Text(
                          p.titulo,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          p.texto,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_paginas.length, (i) {
                final activa = i == _pagina;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: activa ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: activa
                        ? AppColors.primario
                        : AppColors.primario.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: CustomButton(
                texto: esUltima ? 'Comenzar' : 'Siguiente',
                onPressed: _siguiente,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
