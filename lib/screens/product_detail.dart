import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/product/product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({required this.product, super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Cart _cartChangeNotifier;

  @override
  void initState() {
    super.initState();
    _cartChangeNotifier = context.read<Cart>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.title!,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      bottomNavigationBar: ListenableBuilder(
          listenable: _cartChangeNotifier,
          builder: (context, child) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.orange[900],
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 24,
                  ),
                ),
                onPressed: () {
                  _cartChangeNotifier.addItem(product: widget.product);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_cartChangeNotifier.itemCount > 0 &&
                        _cartChangeNotifier.items.containsKey(widget.product.id.toString()))
                      Container(
                        height: 20,
                        width: 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            '${_cartChangeNotifier.items[widget.product.id.toString()]!.quantity}',
                            style: TextStyle(
                              color: Colors.orange[900],
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Add to Cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: widget.product.image!,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  placeholder: (context, url) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.product.category!),
                      const SizedBox(height: 2),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(
                            Iconsax.star1,
                            color: Colors.orange[900],
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${widget.product.rating!.rate}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.product.title!,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$${widget.product.price}',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.product.description!,
                    textAlign: TextAlign.start,
                    softWrap: true,
                    style: GoogleFonts.poppins(
                      color: Colors.black87,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
