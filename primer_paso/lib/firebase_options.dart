// Archivo de compatibilidad para la etapa local de la app.
// No se usa Firebase en esta versión, por lo que no depende de paquetes nativos.
class FirebaseOptions {
  const FirebaseOptions();
}

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => const FirebaseOptions();

  static const FirebaseOptions web = FirebaseOptions();
  static const FirebaseOptions android = FirebaseOptions();
  static const FirebaseOptions ios = FirebaseOptions();
  static const FirebaseOptions macos = FirebaseOptions();
  static const FirebaseOptions windows = FirebaseOptions();
}
