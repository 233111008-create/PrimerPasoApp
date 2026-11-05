import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get usuarioId => _auth.currentUser?.uid;
  String? get usuarioActual => _auth.currentUser?.email;
  bool get haySesion => _auth.currentUser != null;

  Future<bool> restaurarSesion() async {
    return _auth.currentUser != null;
  }

  Future<void> registrar(String correo, String contrasena) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: correo,
        password: contrasena,
      );
    } on FirebaseAuthException catch (error) {
      throw AuthException(_mensajeError(error));
    }
  }

  Future<void> iniciarSesion(String correo, String contrasena) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: correo,
        password: contrasena,
      );
    } on FirebaseAuthException catch (error) {
      throw AuthException(_mensajeError(error));
    }
  }

  Future<void> cerrarSesion() => _auth.signOut();

  String _mensajeError(FirebaseAuthException error) {
    return switch (error.code) {
      'email-already-in-use' => 'El correo electrónico ya está en uso.',
      'weak-password' => 'La contraseña es demasiado débil.',
      'invalid-email' => 'El correo electrónico no es válido.',
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' => 'Correo o contraseña incorrectos.',
      'network-request-failed' =>
        'No hay conexión. Revisa tu internet e inténtalo de nuevo.',
      'too-many-requests' =>
        'Demasiados intentos. Espera un momento y vuelve a intentar.',
      'operation-not-allowed' =>
        'Activa el acceso con correo y contraseña en Firebase Console.',
      _ => 'No se pudo completar la autenticación (${error.code}).',
    };
  }
}

class AuthException implements Exception {
  final String mensaje;
  AuthException(this.mensaje);
}
