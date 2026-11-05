/// Tipos de oportunidad que maneja la app (filtros del catálogo).
enum TipoOportunidad { vacante, beca, practica }

extension TipoOportunidadX on TipoOportunidad {
  String get etiqueta {
    switch (this) {
      case TipoOportunidad.vacante:
        return 'Vacante';
      case TipoOportunidad.beca:
        return 'Beca';
      case TipoOportunidad.practica:
        return 'Práctica';
    }
  }
}

/// Modelo de datos de una oportunidad (vacante, beca o práctica).
/// Es inmutable; el estado de "favorito" lo maneja FavoritosProvider.
class Vacante {
  final String id;
  final String titulo;
  final String empresa;
  final TipoOportunidad tipo;
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

  /// Convierte la vacante a un mapa para guardarla en Firestore.
  Map<String, dynamic> toMap() => {
        'titulo': titulo,
        'empresa': empresa,
        'tipo': tipo.name,
        'modalidad': modalidad,
        'ubicacion': ubicacion,
        'apoyo': apoyo,
        'fechaLimite': fechaLimite,
        'descripcion': descripcion,
        'requisitos': requisitos,
        'rutaImagen': rutaImagen,
      };

  /// Construye una vacante desde un documento de Firestore.
  factory Vacante.fromMap(String id, Map<String, dynamic> map) {
    return Vacante(
      id: id,
      titulo: map['titulo'] as String,
      empresa: map['empresa'] as String,
      tipo: TipoOportunidad.values.byName(map['tipo'] as String),
      modalidad: map['modalidad'] as String,
      ubicacion: map['ubicacion'] as String,
      apoyo: map['apoyo'] as String,
      fechaLimite: map['fechaLimite'] as String,
      descripcion: map['descripcion'] as String,
      requisitos: List<String>.from(map['requisitos'] as List),
      rutaImagen: map['rutaImagen'] as String?,
    );
  }
}
