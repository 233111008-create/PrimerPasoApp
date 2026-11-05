import 'package:flutter/material.dart';

import 'favoritos_repository.dart';

Future<void> ejecutarCambioFavorito(
  BuildContext context,
  Future<void> Function() cambio,
) async {
  try {
    await cambio();
  } on FavoritosStorageException catch (error) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(error.mensaje)));
  }
}
