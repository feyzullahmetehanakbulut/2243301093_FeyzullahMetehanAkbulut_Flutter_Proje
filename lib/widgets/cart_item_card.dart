import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final bool isFavorite;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;
  final VoidCallback onFavorite;

  const CartItemCard({
    super.key,
    required this.item,
    required this.isFavorite,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
    required this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final product = item.product;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        leading: const Icon(Icons.image),
        title: Text(product.name),
        subtitle: Text('${product.price.toStringAsFixed(0)} TL - Adet: ${item.quantity}'),
        trailing: Wrap(
          children: [
            IconButton(
              onPressed: onFavorite,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
            ),
            IconButton(onPressed: onDecrease, icon: const Icon(Icons.remove)),
            IconButton(onPressed: onIncrease, icon: const Icon(Icons.add)),
            IconButton(onPressed: onRemove, icon: const Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
