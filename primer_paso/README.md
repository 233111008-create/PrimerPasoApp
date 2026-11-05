# Primer Paso

Aplicación Flutter para explorar vacantes, becas y prácticas para jóvenes.

## Ejecutar

```shell
flutter pub get
flutter run
```

Los recursos visuales se cargan desde `img/`, declarado como carpeta de assets
en `pubspec.yaml`.

## Firebase

La app inicializa Firebase al arrancar y usa Firebase Authentication para crear
cuentas, iniciar sesión y cerrar sesión con correo y contraseña. Habilita el
proveedor **Correo electrónico/contraseña** en Firebase Console antes de probar
el acceso. Las opciones de Firebase se encuentran en `lib/firebase_options.dart`;
si cambias de proyecto, vuelve a generarlas con FlutterFire CLI.

Las oportunidades de ejemplo y los favoritos se mantienen localmente. Los
favoritos se guardan por cuenta y sobreviven al cierre de sesión y al reinicio
de la app, pero todavía no se sincronizan entre dispositivos con Cloud Firestore.
