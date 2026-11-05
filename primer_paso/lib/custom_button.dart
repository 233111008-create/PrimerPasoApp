import 'package:flutter/material.dart';
import 'core_theme.dart';

/// [outlined] = true da la variante secundaria (ej. "Mis favoritos").
class CustomButton extends StatelessWidget {
  final String texto;
  final IconData? icono;
  final VoidCallback onPressed;
  final bool outlined;

  const CustomButton({
    super.key,
    required this.texto,
    required this.onPressed,
    this.icono,
    this.outlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final etiqueta = Text(texto);
    final icon = icono == null ? null : Icon(icono);

    return SizedBox(
      width: double.infinity,
      child: outlined
          ? OutlinedButton.icon(
              onPressed: onPressed,
              icon: icon ?? const SizedBox.shrink(),
              label: etiqueta,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primario,
                side: const BorderSide(color: AppColors.primario),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            )
          : ElevatedButton.icon(
              onPressed: onPressed,
              icon: icon ?? const SizedBox.shrink(),
              label: etiqueta,
            ),
    );
  }
}
