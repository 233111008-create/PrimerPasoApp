import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_routes.dart';
import 'auth_repository.dart';
import 'core_theme.dart';
import 'custom_button.dart';
import 'favoritos_provider.dart';
import 'vacante_model.dart';
import 'vacante_repository.dart';

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
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.auth,
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
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              color: AppColors.primario,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hola', style: TextStyle(color: Colors.white70)),
                SizedBox(height: AppSpacing.sm),
                Text(
                  'Da tu primer paso hacia un trabajo decente',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  'Vacantes, becas y prácticas para jóvenes (ODS 8).',
                  style: TextStyle(color: Colors.white70),
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
          Text('Explora por tipo',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              for (final tipo in TipoOportunidad.values)
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
            onPressed: () => Navigator.pushNamed(context, AppRoutes.vacantes),
          ),
          const SizedBox(height: AppSpacing.md),
          CustomButton(
            texto: 'Mis favoritos',
            icono: Icons.favorite_border,
            outlined: true,
            onPressed: () => Navigator.pushNamed(context, AppRoutes.favoritos),
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
      ),
      child: Column(
        children: [
          Icon(icono, color: AppColors.primario),
          const SizedBox(height: AppSpacing.xs),
          Text(valor,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
          Text(etiqueta, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _AccesoTipo extends StatelessWidget {
  final TipoOportunidad tipo;

  const _AccesoTipo({required this.tipo});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.colorTipo(tipo);
    // Etiqueta en plural para el acceso rápido.
    final nombre = tipo == TipoOportunidad.practica
        ? 'Prácticas'
        : '${tipo.etiqueta}s';

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () =>
          Navigator.pushNamed(context, AppRoutes.vacantes, arguments: tipo),
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
            Text(nombre,
                style: TextStyle(color: color, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
