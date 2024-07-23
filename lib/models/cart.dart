import 'package:flutter/material.dart';

import 'product/product.dart';

class CartItem {
  final String id;
  final String imageUrl;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.quantity,
    required this.price,
  });

  @override
  String toString() {
    return 'CartItem(id: $id, title: $title, quantity: $quantity, price: $price)';
  }
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem({required Product product}) {
    if (_items.containsKey(product.id.toString())) {
      _items.update(
        product.id.toString(),
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          imageUrl: existingCartItem.imageUrl,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1,
          price: existingCartItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id.toString(),
        () => CartItem(
          id: product.id.toString(),
          imageUrl: product.image!,
          title: product.title!,
          price: product.price!,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    debugPrint("The items are $_items and the product id is $productId");
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
