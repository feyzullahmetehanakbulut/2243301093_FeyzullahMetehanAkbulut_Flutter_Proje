import 'package:flutter/material.dart';
import '../../data/app_data.dart';
import '../../models/app_log.dart';
import '../../models/cart_item.dart';
import '../../models/order.dart';
import '../../models/product.dart';
import '../shared/profile_page.dart';
import 'campaigns_page.dart';
import 'cart_page.dart';
import 'favorites_page.dart';
import 'payment_page.dart';
import 'product_list_page.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  int selectedIndex = 0;

  final List<CartItem> cartItems = [];
  final List<Product> favoriteItems = [];
  final List<Product> pastOrders = [];

  void changePage(int index) {
    setState(() => selectedIndex = index);
  }

  void addToCart(Product product) {
    setState(() {
      final index = cartItems.indexWhere((item) => item.product.id == product.id);
      if (index == -1) {
        cartItems.add(CartItem(product: product, quantity: 1));
      } else {
        cartItems[index].quantity++;
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.name} sepete eklendi')),
    );
  }

  void toggleFavorite(Product product) {
    setState(() {
      final exists = favoriteItems.any((item) => item.id == product.id);
      if (exists) {
        favoriteItems.removeWhere((item) => item.id == product.id);
      } else {
        favoriteItems.add(product);
      }
    });
  }

  bool isFavorite(Product product) {
    return favoriteItems.any((item) => item.id == product.id);
  }

  void increaseQuantity(Product product) {
    setState(() {
      cartItems.firstWhere((item) => item.product.id == product.id).quantity++;
    });
  }

  void decreaseQuantity(Product product) {
    setState(() {
      final index = cartItems.indexWhere((item) => item.product.id == product.id);
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        cartItems.removeAt(index);
      }
    });
  }

  void removeFromCart(Product product) {
    setState(() {
      cartItems.removeWhere((item) => item.product.id == product.id);
    });
  }

  double get totalPrice {
    return cartItems.fold(
      0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
  }

  void goPaymentPage() {
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sepetiniz boş')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PaymentPage(
          cartItems: cartItems,
          totalPrice: totalPrice,
          onPaymentCompleted: (address) {
            setState(() {
              final copiedItems = cartItems
                  .map((item) => CartItem(product: item.product, quantity: item.quantity))
                  .toList();

              final order = Order(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                items: copiedItems,
                totalPrice: totalPrice,
                address: address,
                status: 'Onay Bekliyor',
              );

              globalOrders.add(order);

              addLog(
                LogType.orderCreated,
                'Müşteri sipariş oluşturdu',
                'Sipariş No: ${order.id}\n'
                    'Müşteri: $testName\n'
                    'E-posta: $testEmail\n'
                    'Toplam: ${order.totalPrice.toStringAsFixed(0)} TL\n'
                    'Adres: ${order.address}\n'
                    'Ürünler:\n${order.items.map((e) => "- ${e.product.name} x${e.quantity}").join("\n")}',
              );

              for (final item in cartItems) {
                pastOrders.add(item.product);
              }

              cartItems.clear();
              selectedIndex = 0;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      ProductListPage(
        onAddToCart: addToCart,
        onFavorite: toggleFavorite,
        isFavorite: isFavorite,
      ),
      const CampaignsPage(),
      CartPage(
        cartItems: cartItems,
        totalPrice: totalPrice,
        onIncrease: increaseQuantity,
        onDecrease: decreaseQuantity,
        onRemove: removeFromCart,
        onPayment: goPaymentPage,
        onFavorite: toggleFavorite,
        isFavorite: isFavorite,
      ),
      FavoritesPage(
        favoriteItems: favoriteItems,
        pastOrders: pastOrders,
        onAddToCart: addToCart,
        onFavorite: toggleFavorite,
        isFavorite: isFavorite,
      ),
      ProfilePage(
        isAdmin: false,
        onGoOrders: () => changePage(2),
        onGoFavorites: () => changePage(3),
        onGoHistory: () => changePage(3),
      ),
    ];

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: changePage,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          NavigationDestination(icon: Icon(Icons.local_offer), label: 'Kampanya'),
          NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'Sepet'),
          NavigationDestination(icon: Icon(Icons.favorite), label: 'Favoriler'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
