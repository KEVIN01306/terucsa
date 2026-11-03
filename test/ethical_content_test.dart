import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:terucsa/models/ethical_content.dart';

void main() {
  test('Verificar parseo correcto de assets/data/ethical_projection.json', () {
    final file = File('assets/data/ethical_projection.json');
    expect(file.existsSync(), isTrue, reason: 'El archivo JSON debe existir en assets/data/');

    final jsonString = file.readAsStringSync();
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    final content = EthicalContent.fromJson(jsonMap);

    // Header y Home
    expect(content.header.kicker, equals('Proyección Ética'));
    expect(content.header.title, contains('Aristóteles, Kant'));
    expect(content.home.stations.length, equals(3));
    expect(content.home.stations[0].num, equals('FASE 01'));
    expect(content.home.stations[1].num, equals('FASE 02'));
    expect(content.home.stations[2].num, equals('FASE 03'));

    // Estación 1
    expect(content.station1.options.length, equals(3));
    expect(content.station1.options[0].id, equals('deficit'));
    expect(content.station1.options[1].id, equals('excess'));
    expect(content.station1.options[2].id, equals('mean'));

    // Estación 2
    expect(content.station2.areas.length, equals(9));
    expect(content.station2.choices.length, equals(2));
    for (final area in content.station2.areas) {
      expect(area.scenarios.isNotEmpty, isTrue);
    }
    expect(content.station2.certificate.title, equals('Compromiso Categórico'));

    // Estación 3
    expect(content.station3.dilemmas.length, equals(7));
    expect(content.station3.steps.length, equals(3));
  });
}
