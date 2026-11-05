/// Sesión local para la Etapa 1 (sin Firebase). Los usuarios viven en memoria.
/// En la Etapa 2 se cambia solo el cuerpo de estos métodos por Firebase Auth.
class AuthRepository {
  static final Map<String, String> _usuarios = {};
  static String? _correoActual;

  String? get usuarioActual => _correoActual;
  bool get haySesion => _correoActual != null;

  Future<bool> restaurarSesion() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _correoActual != null;
  }

  Future<void> registrar(String correo, String contrasena) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (_usuarios.containsKey(correo)) {
      throw AuthException('El correo electrónico ya está en uso.');
    }
    _usuarios[correo] = contrasena;
    _correoActual = correo;
  }

  Future<void> iniciarSesion(String correo, String contrasena) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (_usuarios[correo] != contrasena) {
      throw AuthException('Correo o contraseña incorrectos.');
    }
    _correoActual = correo;
  }

  Future<void> cerrarSesion() async {
    _correoActual = null;
  }
}

class AuthException implements Exception {
  final String mensaje;
  AuthException(this.mensaje);
}
