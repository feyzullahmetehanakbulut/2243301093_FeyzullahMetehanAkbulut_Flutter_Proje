import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../widgets/page_template.dart';
import '../../widgets/product_card.dart';

class FavoritesPage extends StatelessWidget {
  final List<Product> favoriteItems;
  final List<Product> pastOrders;
  final void Function(Product product) onAddToCart;
  final void Function(Product product) onFavorite;
  final bool Function(Product product) isFavorite;

  const FavoritesPage({
    super.key,
    required this.favoriteItems,
    required this.pastOrders,
    required this.onAddToCart,
    required this.onFavorite,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Favorilerim',
      child: ListView(
        children: [
          const Text('Favorilerim', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          if (favoriteItems.isEmpty)
            const Text('Henüz favori ürün yok')
          else
            ...favoriteItems.map((p) {
              return ProductCard(
                product: p,
                buttonText: 'Sepete Ekle',
                isFavorite: isFavorite(p),
                onButtonTap: () => onAddToCart(p),
                onFavoriteTap: () => onFavorite(p),
              );
            }),
          const SizedBox(height: 24),
          const Text('Sipariş Geçmişi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          if (pastOrders.isEmpty)
            const Text('Henüz sipariş geçmişi yok')
          else
            ...pastOrders.map((p) {
              return ProductCard(
                product: p,
                buttonText: 'Tekrarla',
                isFavorite: isFavorite(p),
                onButtonTap: () => onAddToCart(p),
                onFavoriteTap: () => onFavorite(p),
              );
            }),
        ],
      ),
    );
  }
}
