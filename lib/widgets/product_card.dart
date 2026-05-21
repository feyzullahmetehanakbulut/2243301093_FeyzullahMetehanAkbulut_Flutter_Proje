import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final String buttonText;
  final bool isFavorite;
  final VoidCallback onButtonTap;
  final VoidCallback onFavoriteTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.buttonText,
    required this.isFavorite,
    required this.onButtonTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              width: 85,
              height: 85,
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.image),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('${product.price.toStringAsFixed(0)} TL'),
                  Text(product.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                  Chip(label: Text(product.status)),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: onFavoriteTap,
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                ),
                TextButton(
                  onPressed: onButtonTap,
                  child: Text(buttonText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
