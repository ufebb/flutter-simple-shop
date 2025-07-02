// lib/providers/cart_provider.dart
import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<int, CartItem> _items = {};

  List<CartItem> get items {
    return _items.values.toList();
  }

  int get itemCount {
    return _items.length;
  }

  // Getter baru untuk mendapatkan total kuantitas dari semua produk di keranjang
  int get totalProductQuantity {
    int total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity;
    });
    return total;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.totalPrice;
    });
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingCartItem) => CartItem(
          product: existingCartItem.product,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          product: product,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void increaseQuantity(int productId) {
    if (_items.containsKey(productId)) {
      _items.update(productId, (existingItem) {
        existingItem.incrementQuantity();
        return existingItem;
      });
      notifyListeners();
    }
  }

  void decreaseQuantity(int productId) {
    if (_items.containsKey(productId)) {
      _items.update(productId, (existingItem) {
        existingItem.decrementQuantity();
        if (existingItem.quantity == 0) {
          _items.remove(productId);
        }
        return existingItem;
      });
      notifyListeners();
    }
  }

  void removeItem(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}