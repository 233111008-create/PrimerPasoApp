/// Etapa 1: no persistimos favoritos en ningún backend. Este repositorio existe
/// solo para mantener compatibilidad con el flujo actual de la app.
class FavoritosRepository {
  Future<List<String>> obtenerIds() async => const [];

  Future<void> agregar(String idVacante) async {}

  Future<void> quitar(String idVacante) async {}
}
