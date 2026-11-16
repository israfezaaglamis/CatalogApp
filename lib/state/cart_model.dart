import 'package:flutter/foundation.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  int quantity;
  CartItem(this.product, this.quantity);
}

/// Basit state yönetimi: ChangeNotifier + AnimatedBuilder (ekstra paket yok).
class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  int get totalCount => _items.fold(0, (s, i) => s + i.quantity);
  double get totalPrice =>
      _items.fold(0.0, (s, i) => s + i.product.price * i.quantity);

  void add(Product p) {
    final index = _items.indexWhere((i) => i.product.id == p.id);
    if (index >= 0) {
      if (_items[index].quantity < p.stock) _items[index].quantity++;
    } else {
      _items.add(CartItem(p, 1));
    }
    notifyListeners();
  }

  void decrease(Product p) {
    final index = _items.indexWhere((i) => i.product.id == p.id);
    if (index < 0) return;
    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }
    notifyListeners();
  }

  void remove(Product p) {
    _items.removeWhere((i) => i.product.id == p.id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

final CartModel cart = CartModel();
