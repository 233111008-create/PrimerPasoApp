// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:primer_paso/favoritos_provider.dart';
import 'package:primer_paso/vacante_repository.dart';
import 'package:primer_paso/vacantes_semilla.dart';

void main() {
  test('Favoritos se mantienen después de cerrar sesión', () async {
    SharedPreferences.setMockInitialValues({});
    await VacanteRepository().cargar();
    final provider = FavoritosProvider();
    final vacante = vacantesSemilla.first;

    await provider.cargar('usuario-1');
    expect(provider.cantidad, 0);

    await provider.agregar(vacante);
    expect(provider.cantidad, 1);
    expect(provider.esFavorito(vacante.id), isTrue);

    provider.limpiar();
    expect(provider.cantidad, 0);

    await provider.cargar('usuario-1');
    expect(provider.esFavorito(vacante.id), isTrue);

    await provider.cargar('usuario-2');
    expect(provider.cantidad, 0);

    await provider.alternar(vacante);
    expect(provider.cantidad, 1);
    expect(provider.esFavorito(vacante.id), isTrue);

    await provider.alternar(vacante);
    expect(provider.cantidad, 0);
    expect(provider.esFavorito(vacante.id), isFalse);
  });
}
