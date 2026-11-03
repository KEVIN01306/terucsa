import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:terucsa/main.dart';

void main() {
  testWidgets('Carga inicial de ProyeccionEticaApp y despliegue del menú de estaciones', (WidgetTester tester) async {
    // Mock para que rootBundle devuelva el contenido de assets/data/ethical_projection.json
    final file = File('assets/data/ethical_projection.json');
    final jsonString = file.readAsStringSync();

    TestWidgetsFlutterBinding.ensureInitialized();
    tester.binding.defaultBinaryMessenger.setMockMessageHandler(
      'flutter/assets',
      (ByteData? message) async {
        final key = utf8.decode(message!.buffer.asUint8List());
        if (key == 'assets/data/ethical_projection.json') {
          return ByteData.view(Uint8List.fromList(utf8.encode(jsonString)).buffer);
        }
        return null;
      },
    );

    await tester.pumpWidget(const ProyeccionEticaApp());
    await tester.pumpAndSettle();

    // Verificamos que se renderiza el header y las estaciones
    expect(find.text('Proyección Ética'), findsAtLeastNWidgets(1));
    expect(find.textContaining('Aristóteles, Kant'), findsOneWidget);
    expect(find.text('El Termómetro del Carácter'), findsOneWidget);
    expect(find.text('El Escáner Kantiano'), findsOneWidget);
    expect(find.text('La Ruleta del Conflicto'), findsOneWidget);

    // Tocamos la Estación 1
    await tester.tap(find.text('El Termómetro del Carácter'));
    await tester.pumpAndSettle();

    // Verificamos que estamos en la pantalla de la Estación 1 (Intro)
    expect(find.text('Una brújula rápida para descubrir qué virtud profesional necesitas cultivar.'), findsOneWidget);
    expect(find.text('Comenzar'), findsOneWidget);

    // Tocamos "Comenzar"
    await tester.tap(find.text('Comenzar'));
    await tester.pumpAndSettle();

    // Verificamos que estamos en la pregunta
    expect(find.text('Frente a una injusticia en tu profesión, ¿qué haces?'), findsOneWidget);
    expect(find.text('Callo para no tener problemas'), findsOneWidget);
  });
}
