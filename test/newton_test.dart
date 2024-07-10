// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto_fisica/logic/newton.dart';

void main() {
  Newton newton = Newton(mass1: 10, mass2: 20, angle: 30);

  test('sacar el peso 1', () {
    // Llama a la función
    final resultado = newton.weight1X;

    // Verifica que el resultado sea correcto
    expect(resultado, 98);
  });

  test('sacar el peso 2', () {
    // Llama a la función
    final resultado = newton.weight2;

    // Verifica que el resultado sea correcto
    expect(resultado, 196);
  });

  test('sacar la normal', () {
    // Llama a la función
    final resultado = newton.normal;

    // Verifica que el resultado sea correcto
    expect(resultado, 49);
  });

  test('sacar la fuerza de fricción', () {
    // Llama a la función
    final resultado = newton.frictionForce;

    // Verifica que el resultado sea correcto
    expect(resultado, 24.5);
  });

  test('sacar la aceleración', () {
    // Llama a la función
    final resultado = newton.acceleration;

    // Verifica que el resultado sea correcto
    expect(resultado, 0.5);
  });

  test('sacar la tensión', () {
    // Llama a la función
    final resultado = newton.tension;

    // Verifica que el resultado sea correcto
    expect(resultado, 5);
  });

  test('sacar la masa total', () {
    // Llama a la función
    final resultado = newton.totalMass();

    // Verifica que el resultado sea correcto
    expect(resultado, 30);
  });

  test('sacar la masa más pesada', () {
    // Llama a la función
    final resultado = newton.heavier();

    // Verifica que el resultado sea correcto
    expect(resultado, 20);
  });
}
