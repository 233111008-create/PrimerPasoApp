import 'package:flutter/material.dart';

import 'vacante_model.dart';


class FavoritosProvider extends ChangeNotifier {
  final List<Vacante> _favoritos = [];

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
