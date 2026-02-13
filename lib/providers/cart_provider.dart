import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  int get itemCount =>
      _cartItems.fold<int>(0, (sum, item) => sum + (item['qty'] ?? 1) as int);

  bool isInCart(Map<String, dynamic> product) {
    return _cartItems.any((item) => item["id"] == product["id"]);
  }

  void addToCart(Map<String, dynamic> product) {
    if (!isInCart(product)) {
      _cartItems.add({...product, "qty": 1});
      notifyListeners();
    }
  }

  void removeFromCart(Map<String, dynamic> product) {
    _cartItems.removeWhere((item) => item["id"] == product["id"]);
    notifyListeners();
  }

  void increaseQty(Map<String, dynamic> product) {
    final index = _cartItems.indexWhere((item) => item["id"] == product["id"]);
    if (index != -1) {
      _cartItems[index]["qty"]++;
      notifyListeners();
    }
  }

  void decreaseQty(Map<String, dynamic> product) {
    final index = _cartItems.indexWhere((item) => item["id"] == product["id"]);
    if (index != -1 && _cartItems[index]["qty"] > 1) {
      _cartItems[index]["qty"]--;
      notifyListeners();
    }
  }
}
