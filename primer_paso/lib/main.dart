import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core_theme.dart';
import 'favoritos_provider.dart';
import 'firebase_options.dart';
import 'splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritosProvider(),
      child: const PrimerPasoApp(),
    ),
  );
}

class PrimerPasoApp extends StatelessWidget {
  const PrimerPasoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Primer Paso',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const SplashScreen(),
    );
  }
}
