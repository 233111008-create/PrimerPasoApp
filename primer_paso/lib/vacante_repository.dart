import 'vacante_model.dart';
import 'vacantes_semilla.dart';

/// Etapa 1: datos locales (lista fija). En la Etapa 2 solo se cambia este
/// Repository por Firestore.
class VacanteRepository {
  final List<Vacante> _vacantes = List.of(vacantesSemilla)
    ..sort((a, b) => a.fechaLimite.compareTo(b.fechaLimite));

  List<Vacante> obtenerVacantes() => _vacantes;

  List<Vacante> filtrar({String? tipo, String busqueda = ''}) {
    final q = busqueda.trim().toLowerCase();
    return _vacantes.where((v) {
      final coincideTipo = tipo == null || v.tipo == tipo;
      final coincideTexto = q.isEmpty ||
          v.titulo.toLowerCase().contains(q) ||
          v.empresa.toLowerCase().contains(q) ||
          v.ubicacion.toLowerCase().contains(q);
      return coincideTipo && coincideTexto;
    }).toList();
  }
}
