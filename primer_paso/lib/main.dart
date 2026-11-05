import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_routes.dart';
import 'core_theme.dart';
import 'favoritos_provider.dart';

void main() {
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
      initialRoute: AppRoutes.splash,
      onGenerateRoute: generarRuta,
    );
  }
}
