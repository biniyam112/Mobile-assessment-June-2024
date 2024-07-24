import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/models/cart.dart';
import 'package:flutter_assessment/screens/cart_screen.dart';
import '../models/product/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({required this.product, super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List<CartItem> items = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.product.title!,
            style: const TextStyle(
              color: Color.fromARGB(221, 3, 101, 111),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            const Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                'Add to Cart',
                style: TextStyle(
                  color: Color.fromARGB(221, 3, 101, 111),
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Color.fromARGB(221, 3, 101, 111),
                  size: 30,
                ),
                onPressed: () {
                  items.add(CartItem(
                      title: widget.product.title!,
                      id: '',
                      price: widget.product.price,
                      quantity: 1));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(cartItems: items),
                    ),
                  );
                },
              ),
            ),
          ],
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(221, 3, 101, 111),
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: widget.product.image!,
                height: 500,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                placeholder: (context, url) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.orange[900],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "Getting item image",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '\$${widget.product.price}',
                style: const TextStyle(
                  color: Color.fromARGB(221, 3, 101, 111),
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        widget.product.description!,
                        style: const TextStyle(
                          color: Color.fromARGB(221, 3, 101, 111),
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
