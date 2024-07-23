import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../models/cart.dart';
import '../models/product/product.dart';
import '../widgets/product_item.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<Product> _products = [];
  late Cart _cartChangeNotifier;

  @override
  void initState() {
    super.initState();
    _cartChangeNotifier = context.read<Cart>();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products'))
        .timeout(const Duration(seconds: 20));
    final List<dynamic> productData = json.decode(response.body);
    setState(() {
      _products = productData.map((json) => Product.fromMap(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Products',
        ),
        centerTitle: true,
        actions: [
          Ink(
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const CartScreen(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: ListenableBuilder(
                  listenable: _cartChangeNotifier,
                  builder: (context, child) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        const SizedBox(
                          height: 50,
                          width: 50,
                          child: Center(
                            child: Icon(
                              Iconsax.shopping_bag4,
                            ),
                          ),
                        ),
                        if (_cartChangeNotifier.itemCount > 0)
                          Positioned(
                            top: 4,
                            right: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orange[900],
                              ),
                              height: 20,
                              width: 20,
                              child: Center(
                                child: Text(
                                  "${_cartChangeNotifier.itemCount}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: RefreshIndicator(
            onRefresh: () async {
              await _fetchProducts();
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: _products.length,
              itemBuilder: (ctx, i) => ProductItem(product: _products[i]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
