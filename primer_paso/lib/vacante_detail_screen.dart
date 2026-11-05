import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core_theme.dart';
import 'custom_button.dart';
import 'favoritos_provider.dart';
import 'favoritos_ui.dart';
import 'vacante_model.dart';

/// Detalle: recibe la [Vacante] como argumento de navegación.
class VacanteDetailScreen extends StatelessWidget {
  final Vacante vacante;

  const VacanteDetailScreen({super.key, required this.vacante});

  @override
  Widget build(BuildContext context) {
    final esFavorito = context.watch<FavoritosProvider>().esFavorito(
      vacante.id,
    );
    final color = AppColors.colorTipo(vacante.tipo);
    final estilo = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(vacante.tipo.etiqueta)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                AppColors.iconoTipo(vacante.tipo),
                size: 32,
                color: color,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(vacante.titulo, style: estilo.headlineSmall),
          const SizedBox(height: AppSpacing.xs),
          Text(vacante.empresa, style: estilo.bodyMedium),
          const SizedBox(height: AppSpacing.lg),
          _Dato(
            icono: Icons.location_on_outlined,
            titulo: 'Ubicación',
            valor: '${vacante.ubicacion} · ${vacante.modalidad}',
          ),
          _Dato(
            icono: Icons.payments_outlined,
            titulo: 'Apoyo',
            valor: vacante.apoyo,
          ),
          _Dato(
            icono: Icons.event_outlined,
            titulo: 'Fecha límite',
            valor: vacante.fechaLimite,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text('Descripción', style: estilo.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          Text(vacante.descripcion, style: estilo.bodyMedium),
          const SizedBox(height: AppSpacing.lg),
          Text('Requisitos', style: estilo.titleMedium),
          const SizedBox(height: AppSpacing.sm),
          for (final r in vacante.requisitos)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Row(
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    size: 20,
                    color: AppColors.primario,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: Text(r, style: estilo.bodyMedium)),
                ],
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
          CustomButton(
            texto: esFavorito ? 'Quitar de favoritos' : 'Guardar en favoritos',
            icono: esFavorito ? Icons.favorite : Icons.favorite_border,
            onPressed: () => ejecutarCambioFavorito(
              context,
              () => context.read<FavoritosProvider>().alternar(vacante),
            ),
          ),
        ],
      ),
    );
  }
}

class _Dato extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String valor;

  const _Dato({required this.icono, required this.titulo, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icono, color: AppColors.primario),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo, style: Theme.of(context).textTheme.bodyMedium),
                Text(
                  valor,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textoPrincipal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
