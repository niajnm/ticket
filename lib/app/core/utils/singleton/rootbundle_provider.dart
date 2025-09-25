import 'dart:convert';
import 'package:flutter/services.dart';

class RootBundleProvider {
  // Private constructor
  RootBundleProvider._internal();

  // Singleton instance
  static RootBundleProvider? _instance;

  // Getter to access the singleton
  static RootBundleProvider get instance {
    _instance ??= RootBundleProvider._internal();
    return _instance!;
  }

  /// Loads a JSON file from assets and decodes it as List
  Future<List<dynamic>> loadJson(String path) async {
    final data = await rootBundle.loadString(path);
    final jsonData = json.decode(data) as List<dynamic>;
    return jsonData;
  }

  /// Generic method to load and map JSON to model
  Future<List<T>> loadJsonAsModel<T>(
    String path,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final jsonData = await loadJson(path);
    return jsonData.map((e) => fromJson(e as Map<String, dynamic>)).toList();
  }
}
