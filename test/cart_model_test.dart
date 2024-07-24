import 'package:flutter_assessment/models/cart.dart';
import 'package:flutter_assessment/models/product/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cart', () {
    late Cart cart;

    setUp(() {
      cart = Cart();
    });

    test('should initialize with an empty cart', () {
      expect(cart.items.length, 0);
      expect(cart.itemCount, 0);
      expect(cart.totalAmount, 0.0);
    });

    test('should add a new item to the cart', () {
      final product = Product(
        id: 1,
        title: 'Test Product',
        price: 9.99,
        image: 'https://example.com/product.jpg',
      );

      cart.addItem(product: product);

      expect(cart.items.length, 1);
      expect(cart.itemCount, 1);
      expect(cart.totalAmount, 9.99);
    });

  });
}