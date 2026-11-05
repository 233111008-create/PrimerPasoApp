const List<String> tiposOportunidad = ['Vacante', 'Beca', 'Práctica'];

class Vacante {
  final String id;
  final String titulo;
  final String empresa;
  final String tipo; 
  final String modalidad; 
  final String ubicacion;
  final String apoyo; 
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
