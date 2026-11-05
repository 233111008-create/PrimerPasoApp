/// Tipos de oportunidad que maneja la app (filtros del catálogo).
const List<String> tiposOportunidad = ['Vacante', 'Beca', 'Práctica'];

/// Modelo de datos de una oportunidad (vacante, beca o práctica).
/// Es inmutable; el estado de "favorito" lo maneja FavoritosProvider.
class Vacante {
  final String id;
  final String titulo;
  final String empresa;
  final String tipo; // Vacante, Beca o Práctica
  final String modalidad; // Presencial, Híbrido, Remoto
  final String ubicacion;
  final String apoyo; // sueldo, monto de beca, apoyo económico
  final String fechaLimite; // AAAA-MM-DD
  final String descripcion;
  final List<String> requisitos;
  final String? rutaImagen;

  const Vacante({
    required this.id,
    required this.titulo,
    required this.empresa,
    required this.tipo,
    required this.modalidad,
    required this.ubicacion,
    required this.apoyo,
    required this.fechaLimite,
    required this.descripcion,
    required this.requisitos,
    this.rutaImagen,
  });
}
