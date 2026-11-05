import 'vacante_model.dart';
import 'vacantes_semilla.dart';

/// Etapa 1: datos locales en memoria.
class VacanteRepository {
  static final VacanteRepository _instancia = VacanteRepository._();
  factory VacanteRepository() => _instancia;
  VacanteRepository._();

  List<Vacante> _cache = [];

  Future<void> cargar() async {
    await Future.delayed(const Duration(milliseconds: 400));
    _cache = List.of(vacantesSemilla)
      ..sort((a, b) => a.fechaLimite.compareTo(b.fechaLimite));
  }

  List<Vacante> obtenerVacantes() => _cache;

  Vacante? obtenerPorId(String id) {
    for (final v in _cache) {
      if (v.id == id) return v;
    }
    return null;
  }

  List<Vacante> filtrar({TipoOportunidad? tipo, String busqueda = ''}) {
    final q = busqueda.trim().toLowerCase();
    return _cache.where((v) {
      final coincideTipo = tipo == null || v.tipo == tipo;
      final coincideTexto = q.isEmpty ||
          v.titulo.toLowerCase().contains(q) ||
          v.empresa.toLowerCase().contains(q) ||
          v.ubicacion.toLowerCase().contains(q);
      return coincideTipo && coincideTexto;
    }).toList();
  }
}
