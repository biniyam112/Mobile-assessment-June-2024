import 'package:flutter/material.dart';
import '../models/product/product.dart';
import '../screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).focusColor,
            onPressed: () {
              // Add to cart functionality
            },
          ),
          title: Text(
            product.title!,
            textAlign: TextAlign.center,
          ),
        ),
        child: Image.network(
          product.image!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
