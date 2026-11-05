// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:primer_paso/favoritos_provider.dart';
import 'package:primer_paso/vacante_model.dart';

void main() {
  test('Favoritos se pueden guardar y quitar', () {
    final provider = FavoritosProvider();
    final vacante = Vacante(
      id: 'v-1',
      titulo: 'Desarrollador Flutter',
      empresa: 'Primer Paso',
      tipo: 'Vacante',
      modalidad: 'Remoto',
      ubicacion: 'México',
      apoyo: 'Sueldo competitivo',
      fechaLimite: '2026-12-31',
      descripcion: 'Trabajo para desarrollador móvil.',
      requisitos: ['Flutter', 'Dart'],
    );

    expect(provider.cantidad, 0);

    provider.agregar(vacante);
    expect(provider.cantidad, 1);
    expect(provider.esFavorito(vacante.id), isTrue);

    provider.alternar(vacante);
    expect(provider.cantidad, 0);
    expect(provider.esFavorito(vacante.id), isFalse);
  });
}
