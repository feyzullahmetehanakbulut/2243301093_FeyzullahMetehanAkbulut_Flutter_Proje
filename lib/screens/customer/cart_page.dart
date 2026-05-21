import 'package:flutter/material.dart';
import '../../models/cart_item.dart';
import '../../models/product.dart';
import '../../widgets/cart_item_card.dart';
import '../../widgets/page_template.dart';

class CartPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final double totalPrice;
  final void Function(Product product) onIncrease;
  final void Function(Product product) onDecrease;
  final void Function(Product product) onRemove;
  final VoidCallback onPayment;
  final void Function(Product product) onFavorite;
  final bool Function(Product product) isFavorite;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.totalPrice,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
    required this.onPayment,
    required this.onFavorite,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Sepetim',
      child: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? const Center(child: Text('Sepetiniz boş'))
                : ListView(
                    children: cartItems.map((item) {
                      return CartItemCard(
                        item: item,
                        isFavorite: isFavorite(item.product),
                        onIncrease: () => onIncrease(item.product),
                        onDecrease: () => onDecrease(item.product),
                        onRemove: () => onRemove(item.product),
                        onFavorite: () => onFavorite(item.product),
                      );
                    }).toList(),
                  ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Toplam: ${totalPrice.toStringAsFixed(0)} TL',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onPayment,
                    child: const Text('Ödemeye Geç'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
