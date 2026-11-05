import 'package:flutter/material.dart';

import 'vacante_model.dart';

/// Estado compartido: vacantes, becas y prácticas guardadas en favoritos.
/// Reemplaza a CartProvider.
class FavoritosProvider extends ChangeNotifier {
  final List<Vacante> _favoritos = [];

  /// Lista de solo lectura para que la UI no la modifique directamente.
  List<Vacante> get favoritos => List.unmodifiable(_favoritos);

  int get cantidad => _favoritos.length;

  bool esFavorito(String id) => _favoritos.any((v) => v.id == id);

  void agregar(Vacante vacante) {
    if (esFavorito(vacante.id)) return;
    _favoritos.add(vacante);
    notifyListeners();
  }

  void quitar(String id) {
    _favoritos.removeWhere((v) => v.id == id);
    notifyListeners();
  }

  /// Agrega si no está, quita si ya estaba (botón de corazón).
  void alternar(Vacante vacante) {
    if (esFavorito(vacante.id)) {
      quitar(vacante.id);
    } else {
      agregar(vacante);
    }
  }

  void limpiar() {
    _favoritos.clear();
    notifyListeners();
  }
}
