import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core_theme.dart';
import 'favoritos_provider.dart';
import 'vacante_card.dart';
import 'vacante_detail_screen.dart';

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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VacanteDetailScreen(vacante: v),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
