import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core_theme.dart';
import 'favoritos_provider.dart';
import 'favoritos_screen.dart';
import 'vacante_card.dart';
import 'vacante_detail_screen.dart';
import 'vacante_model.dart';
import 'vacante_repository.dart';

class VacantesScreen extends StatefulWidget {
  final String? tipoInicial;

  const VacantesScreen({super.key, this.tipoInicial});

  @override
  State<VacantesScreen> createState() => _VacantesScreenState();
}

class _VacantesScreenState extends State<VacantesScreen> {
  final VacanteRepository _repository = VacanteRepository();
  final TextEditingController _buscador = TextEditingController();
  String _texto = '';
  String? _tipo;

  @override
  void initState() {
    super.initState();
    _tipo = widget.tipoInicial;
  }

  @override
  void dispose() {
    _buscador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favoritos = context.watch<FavoritosProvider>();
    final lista = _repository.filtrar(tipo: _tipo, busqueda: _texto);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Oportunidades'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritosScreen(),
                ),
              );
            },
            icon: Badge(
              isLabelVisible: favoritos.cantidad > 0,
              label: Text('${favoritos.cantidad}'),
              child: const Icon(Icons.favorite_border),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: TextField(
              controller: _buscador,
              onChanged: (v) => setState(() => _texto = v),
              decoration: const InputDecoration(
                hintText: 'Buscar por puesto, empresa o ciudad',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              children: [
                _chip('Todas', null),
                for (final t in tiposOportunidad) _chip(t, t),
              ],
            ),
          ),
          Expanded(
            child: lista.isEmpty
                ? const Center(child: Text('No se encontraron resultados.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: lista.length,
                    itemBuilder: (context, i) {
                      final v = lista[i];
                      return VacanteCard(
                        vacante: v,
                        esFavorito: favoritos.esFavorito(v.id),
                        onFavorito: () =>
                            context.read<FavoritosProvider>().alternar(v),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VacanteDetailScreen(vacante: v),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String texto, String? tipo) {
    final seleccionado = _tipo == tipo;
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: FilterChip(
        label: Text(texto),
        selected: seleccionado,
        showCheckmark: false,
        labelStyle: TextStyle(
          color: seleccionado ? Colors.white : AppColors.primario,
        ),
        onSelected: (_) => setState(() => _tipo = tipo),
      ),
    );
  }
}
