import 'package:flutter/foundation.dart';

class CartData {
  static ValueNotifier<List<Map<String, dynamic>>> cartItemsNotifier =
      ValueNotifier([]);
  static List<Map<String, dynamic>> get cartItems => cartItemsNotifier.value;

  static bool isInCart(Map<String, dynamic> product) {
    return cartItems.any((item) => item["id"] == product["id"]);
  }

  static void addToCart(Map<String, dynamic> product) {
    if (!isInCart(product)) {
      cartItemsNotifier.value = [
        ...cartItems,
        {...product, "qty": 1},
      ];
    }
  }

  static void removeFromCart(Map<String, dynamic> product) {
    cartItemsNotifier.value = cartItems
        .where((item) => item["id"] != product["id"])
        .toList();
  }

  static void increaseQty(Map<String, dynamic> product) {
    final items = List<Map<String, dynamic>>.from(cartItems);
    final index = items.indexWhere((item) => item["id"] == product["id"]);
    if (index != -1) {
      items[index]["qty"]++;
      cartItemsNotifier.value = items;
    }
  }

  static void decreaseQty(Map<String, dynamic> product) {
    final items = List<Map<String, dynamic>>.from(cartItems);
    final index = items.indexWhere((item) => item["id"] == product["id"]);
    if (index != -1 && items[index]["qty"] > 1) {
      items[index]["qty"]--;
      cartItemsNotifier.value = items;
    }
  }
}
