import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;

    return switch (defaultTargetPlatform) {
      TargetPlatform.android => android,
      TargetPlatform.iOS => ios,
      TargetPlatform.macOS => macos,
      TargetPlatform.windows => windows,
      _ => throw UnsupportedError(
        'Firebase no está configurado para esta plataforma.',
      ),
    };
  }

  static const String _apiKey = 'AIzaSyCUH0BMK950vuhvRFUcK7l-ZOqD5qsXRTQ';
  static const String _projectId = 'primerpaso-92fe3';
  static const String _messagingSenderId = '496098287203';
  static const String _storageBucket = 'primerpaso-92fe3.firebasestorage.app';

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: _apiKey,
    appId: '1:496098287203:web:b9c2023fe9f03b7b1e2256',
    messagingSenderId: _messagingSenderId,
    projectId: _projectId,
    authDomain: 'primerpaso-92fe3.firebaseapp.com',
    storageBucket: _storageBucket,
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: _apiKey,
    appId: '1:496098287203:android:78c29164ebea2b3c1e2256',
    messagingSenderId: _messagingSenderId,
    projectId: _projectId,
    storageBucket: _storageBucket,
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: _apiKey,
    appId: '1:496098287203:ios:083b730c70d822a21e2256',
    messagingSenderId: _messagingSenderId,
    projectId: _projectId,
    storageBucket: _storageBucket,
    iosBundleId: 'com.example.primerPaso',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: _apiKey,
    appId: '1:496098287203:ios:083b730c70d822a21e2256',
    messagingSenderId: _messagingSenderId,
    projectId: _projectId,
    storageBucket: _storageBucket,
    iosBundleId: 'com.example.primerPaso',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: _apiKey,
    appId: '1:496098287203:web:9c8a46fd99db78221e2256',
    messagingSenderId: _messagingSenderId,
    projectId: _projectId,
    authDomain: 'primerpaso-92fe3.firebaseapp.com',
    storageBucket: _storageBucket,
  );
}
