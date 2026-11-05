import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth_screen.dart';
import 'auth_repository.dart';
import 'core_theme.dart';
import 'custom_button.dart';
import 'favoritos_provider.dart';
import 'favoritos_screen.dart';
import 'vacante_model.dart';
import 'vacante_repository.dart';
import 'vacantes_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final total = VacanteRepository().obtenerVacantes().length;
    final guardadas = context.watch<FavoritosProvider>().cantidad;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Primer Paso'),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final favoritos = context.read<FavoritosProvider>();
              await AuthRepository().cerrarSesion();
              favoritos.limpiar();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AuthScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primario, Color(0xFF28577A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.sombra,
                  blurRadius: 24,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'HOLA, QUÉ BUENO VERTE',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const Text(
                        'Tu próximo paso empieza aquí',
                        style: TextStyle(
                          fontSize: 23,
                          height: 1.15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const Text(
                        'Vacantes, becas y prácticas para crecer.',
                        style: TextStyle(color: Colors.white70, height: 1.4),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),
                          child: Text(
                            'ODS 8 · Trabajo decente',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    'img/home.png',
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.school_outlined,
                      size: 56,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _Estadistica(
                  icono: Icons.search,
                  valor: '$total',
                  etiqueta: 'oportunidades',
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _Estadistica(
                  icono: Icons.favorite_border,
                  valor: '$guardadas',
                  etiqueta: 'guardadas',
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Explora por tipo',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              for (final tipo in tiposOportunidad)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: _AccesoTipo(tipo: tipo),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          CustomButton(
            texto: 'Ver todas las oportunidades',
            icono: Icons.list,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const VacantesScreen()),
              );
            },
          ),
          const SizedBox(height: AppSpacing.md),
          CustomButton(
            texto: 'Mis favoritos',
            icono: Icons.favorite_border,
            outlined: true,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritosScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Estadistica extends StatelessWidget {
  final IconData icono;
  final String valor;
  final String etiqueta;

  const _Estadistica({
    required this.icono,
    required this.valor,
    required this.etiqueta,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: AppColors.sombra,
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icono, color: AppColors.primario),
          const SizedBox(height: AppSpacing.xs),
          Text(
            valor,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          Text(etiqueta, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _AccesoTipo extends StatelessWidget {
  final String tipo;

  const _AccesoTipo({required this.tipo});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.colorTipo(tipo);
    // Etiqueta en plural para el acceso rápido.
    final nombre = tipo == 'Práctica' ? 'Prácticas' : '${tipo}s';

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VacantesScreen(tipoInicial: tipo),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            Icon(AppColors.iconoTipo(tipo), color: color),
            const SizedBox(height: AppSpacing.sm),
            Text(
              nombre,
              style: TextStyle(color: color, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
