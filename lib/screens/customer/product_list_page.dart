import 'package:flutter/material.dart';
import '../../data/app_data.dart';
import '../../models/product.dart';
import '../../widgets/page_template.dart';
import '../../widgets/product_card.dart';

class ProductListPage extends StatelessWidget {
  final void Function(Product product) onAddToCart;
  final void Function(Product product) onFavorite;
  final bool Function(Product product) isFavorite;

  const ProductListPage({
    super.key,
    required this.onAddToCart,
    required this.onFavorite,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Ana Sayfa',
      child: ListView(
        children: products.map((product) {
          return ProductCard(
            product: product,
            buttonText: 'Sepete Ekle',
            isFavorite: isFavorite(product),
            onButtonTap: () => onAddToCart(product),
            onFavoriteTap: () => onFavorite(product),
          );
        }).toList(),
      ),
    );
  }
}
