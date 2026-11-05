import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'favoritos_provider.dart';
import 'vacante_repository.dart';

/// Descarga vacantes y favoritos del usuario. Se llama justo después de
/// iniciar sesión (o al restaurar una sesión guardada).
Future<void> cargarDatosIniciales(BuildContext context) async {
  final favoritos = context.read<FavoritosProvider>();
  await VacanteRepository().cargar();
  await favoritos.cargar();
}
