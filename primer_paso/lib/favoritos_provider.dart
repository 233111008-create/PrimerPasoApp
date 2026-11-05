import 'package:flutter/material.dart';

import 'favoritos_repository.dart';
import 'vacante_model.dart';
import 'vacante_repository.dart';

/// Estado compartido: vacantes, becas y prácticas guardadas en favoritos.
/// Reemplaza a CartProvider.
class FavoritosProvider extends ChangeNotifier {
  FavoritosProvider({FavoritosRepository? repository})
    : _repository = repository ?? FavoritosRepository();

  final FavoritosRepository _repository;
  final List<Vacante> _favoritos = [];
  String? _usuarioId;
  Future<void> _escrituraPendiente = Future<void>.value();

  /// Lista de solo lectura para que la UI no la modifique directamente.
  List<Vacante> get favoritos => List.unmodifiable(_favoritos);

  int get cantidad => _favoritos.length;

  Future<void> cargar(String usuarioId) async {
    final ids = (await _repository.obtenerIds(usuarioId)).toSet();
    final disponibles = VacanteRepository().obtenerVacantes();
    _favoritos
      ..clear()
      ..addAll(disponibles.where((vacante) => ids.contains(vacante.id)));
    _usuarioId = usuarioId;
    notifyListeners();
  }

  void limpiar() {
    _favoritos.clear();
    _usuarioId = null;
    notifyListeners();
  }

  bool esFavorito(String id) => _favoritos.any((v) => v.id == id);

  Future<void> agregar(Vacante vacante) async {
    if (esFavorito(vacante.id)) return;
    _favoritos.add(vacante);
    notifyListeners();
    await _guardar();
  }

  Future<void> quitar(String id) async {
    final antes = _favoritos.length;
    _favoritos.removeWhere((v) => v.id == id);
    if (_favoritos.length == antes) return;
    notifyListeners();
    await _guardar();
  }

  /// Agrega si no está, quita si ya estaba (botón de corazón).
  Future<void> alternar(Vacante vacante) async {
    if (esFavorito(vacante.id)) {
      await quitar(vacante.id);
    } else {
      await agregar(vacante);
    }
  }

  Future<void> _guardar() {
    final usuarioId = _usuarioId;
    if (usuarioId == null) {
      throw StateError('Inicia sesión antes de guardar favoritos.');
    }

    final ids = _favoritos.map((vacante) => vacante.id).toList();
    final escritura = _escrituraPendiente.then<void>(
      (_) => _repository.guardarIds(usuarioId, ids),
      onError: (_, _) => _repository.guardarIds(usuarioId, ids),
    );
    _escrituraPendiente = escritura;
    return escritura;
  }
}
