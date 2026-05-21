import 'cart_item.dart';

class Order {
  final String id;
  final List<CartItem> items;
  final double totalPrice;
  final String address;
  String status;

  Order({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.address,
    required this.status,
  });
}
