import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_routes.dart';
import 'core_theme.dart';
import 'favoritos_provider.dart';
import 'vacante_card.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FavoritosProvider>();
    final lista = provider.favoritos;

    return Scaffold(
      appBar: AppBar(title: const Text('Mis favoritos')),
      body: lista.isEmpty
          ? const Center(child: Text('Aún no has guardado oportunidades.'))
          : ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: lista.length,
              itemBuilder: (context, i) {
                final v = lista[i];
                return VacanteCard(
                  vacante: v,
                  esFavorito: true,
                  onFavorito: () =>
                      context.read<FavoritosProvider>().quitar(v.id),
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.detalle,
                    arguments: v,
                  ),
                );
              },
            ),
    );
  }
}
