import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final Function(String itemId) removeItem;

  const CartItemWidget({
    super.key,
    required this.cartItem,
    required this.removeItem,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        removeItem(cartItem.id);
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Card(
          elevation: 0,
          color: Colors.white,
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: cartItem.imageUrl,
                ),
              ),
              title: Text(cartItem.title),
              subtitle:
                  Text('Total: \$${cartItem.price * cartItem.quantity} (\$${cartItem.price}) each'),
              trailing: Text(
                '${cartItem.quantity} x',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
