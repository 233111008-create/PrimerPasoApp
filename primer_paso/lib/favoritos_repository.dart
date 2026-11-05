import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritosRepository {
  String _clave(String usuarioId) => 'favoritos_$usuarioId';

  Future<List<String>> obtenerIds(String usuarioId) async {
    try {
      final preferencias = await SharedPreferences.getInstance();
      return preferencias.getStringList(_clave(usuarioId)) ?? const [];
    } on PlatformException catch (error) {
      throw FavoritosStorageException(
        'No se pudieron cargar tus favoritos: ${error.message ?? error.code}',
      );
    }
  }

  Future<void> guardarIds(String usuarioId, List<String> ids) async {
    try {
      final preferencias = await SharedPreferences.getInstance();
      final guardados = await preferencias.setStringList(
        _clave(usuarioId),
        ids,
      );
      if (!guardados) {
        throw const FavoritosStorageException(
          'No se pudieron guardar tus favoritos. Inténtalo de nuevo.',
        );
      }
    } on PlatformException catch (error) {
      throw FavoritosStorageException(
        'No se pudieron guardar tus favoritos: ${error.message ?? error.code}',
      );
    }
  }
}

class FavoritosStorageException implements Exception {
  final String mensaje;

  const FavoritosStorageException(this.mensaje);
}
