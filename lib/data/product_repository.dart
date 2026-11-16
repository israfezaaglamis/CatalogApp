import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/product.dart';

/// JSON simülasyonu: veriler assets/data/products.json dosyasından okunur.
Future<List<Product>> loadProducts() async {
  final raw = await rootBundle.loadString('assets/data/products.json');
  final list = jsonDecode(raw) as List<dynamic>;
  return list
      .map((e) => Product.fromJson(e as Map<String, dynamic>))
      .toList();
}
