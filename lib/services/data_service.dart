import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/ethical_content.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  EthicalContent? _content;

  /// Carga el JSON central de datos estáticos y dinámicos
  Future<EthicalContent> loadContent() async {
    if (_content != null) {
      return _content!;
    }

    final jsonString = await rootBundle.loadString('assets/data/ethical_projection.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _content = EthicalContent.fromJson(jsonMap);
    return _content!;
  }

  /// Limpia la caché si se requiere recarga
  void clearCache() {
    _content = null;
  }
}
