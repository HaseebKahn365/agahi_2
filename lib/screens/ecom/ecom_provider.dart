import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingItem {
  final String location;
  final int price;

  ShoppingItem({required this.location, required this.price});

  Map<String, dynamic> toJson() => {'location': location, 'price': price};

  static ShoppingItem fromJson(Map<String, dynamic> json) => ShoppingItem(
    location: json['location'] ?? 'unknown',
    price: json['price'] ?? 0,
  );
}

class ShoppingProvider with ChangeNotifier {
  List<ShoppingItem> _items = [];
  List<ShoppingItem> _cartItems = [];

  List<ShoppingItem> get items => _items;
  List<ShoppingItem> get cartItems => _cartItems;

  Future<void> loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? itemsString = prefs.getString('shopping_items');
    final String? cartString = prefs.getString('cart_items');

    if (itemsString != null) {
      final List decoded = jsonDecode(itemsString);
      _items = decoded.map((e) => ShoppingItem.fromJson(e)).toList();
      if (_items.isEmpty) {
        _items = [
          ShoppingItem(location: 'assets/images/ecom1.jpg', price: 100),
          ShoppingItem(location: 'assets/images/ecom2.jpg', price: 600),
          ShoppingItem(location: 'assets/images/ecom3.jpg', price: 300),
        ];
        log('Here are the default items: $_items');
        await saveItems();
      }
    } else {
      _items = [
        ShoppingItem(location: 'assets/images/ecom1.jpg', price: 100),
        ShoppingItem(location: 'assets/images/ecom2.jpg', price: 600),
        ShoppingItem(location: 'assets/images/ecom3.jpg', price: 300),
      ];
      await saveItems();
    }

    if (cartString != null) {
      final List decodedCart = jsonDecode(cartString);
      _cartItems = decodedCart.map((e) => ShoppingItem.fromJson(e)).toList();
    } else {
      _cartItems = [];
      await saveItems();
    }

    log('Loading shopping items: $_items');
    log('Loading cart items: $_cartItems');

    notifyListeners();
  }

  Future<void> saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'shopping_items',
      jsonEncode(_items.map((e) => e.toJson()).toList()),
    );
    await prefs.setString(
      'cart_items',
      jsonEncode(_cartItems.map((e) => e.toJson()).toList()),
    );
  }

  void addToCart(ShoppingItem item) {
    _cartItems.add(item);
    saveItems();
    notifyListeners();
  }

  int getTotal() {
    return _cartItems.fold(0, (sum, item) => sum + item.price);
  }

  void clearCart() {
    _cartItems.clear();
    saveItems();
    notifyListeners();
  }
}
