import 'package:flutter/material.dart';

import 'core_theme.dart';
import 'vacante_model.dart';

/// Componente reutilizable 1: tarjeta de una oportunidad.
/// No tiene lógica: recibe datos y callbacks desde la pantalla.
class VacanteCard extends StatelessWidget {
  final Vacante vacante;
  final bool esFavorito;
  final VoidCallback onTap;
  final VoidCallback onFavorito;

  const VacanteCard({
    super.key,
    required this.vacante,
    required this.esFavorito,
    required this.onTap,
    required this.onFavorito,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.colorTipo(vacante.tipo);

    return Card(
      elevation: 2,
      shadowColor: AppColors.sombra,
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(AppColors.iconoTipo(vacante.tipo), color: color),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vacante.titulo,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      vacante.empresa,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      children: [
                        _Etiqueta(texto: vacante.tipo.etiqueta, color: color),
                        _Etiqueta(
                          texto: vacante.modalidad,
                          color: AppColors.textoSecundario,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: AppColors.textoSecundario,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            vacante.ubicacion,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onFavorito,
                icon: Icon(
                  esFavorito ? Icons.favorite : Icons.favorite_border,
                  color: esFavorito
                      ? AppColors.favorito
                      : AppColors.textoSecundario,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Etiqueta extends StatelessWidget {
  final String texto;
  final Color color;

  const _Etiqueta({required this.texto, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        texto,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}
