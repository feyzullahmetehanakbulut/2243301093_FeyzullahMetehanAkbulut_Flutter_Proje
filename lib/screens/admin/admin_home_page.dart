import 'package:flutter/material.dart';
import '../shared/profile_page.dart';
import 'admin_orders_page.dart';
import 'admin_production_page.dart';
import 'logs_page.dart';
import 'product_form_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int selectedIndex = 0;

  void refresh() {
    setState(() {});
  }

  void changePage(int index) {
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      AdminProductionPage(onRefresh: refresh),
      ProductFormPage(onSaved: refresh),
      AdminOrdersPage(onRefresh: refresh),
      const LogsPage(),
      ProfilePage(
        isAdmin: true,
        onGoOrders: () => changePage(2),
        onGoFavorites: () => changePage(0),
        onGoHistory: () => changePage(3),
      ),
    ];

    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: changePage,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.factory), label: 'Üretim'),
          NavigationDestination(icon: Icon(Icons.add_box), label: 'Ekle'),
          NavigationDestination(icon: Icon(Icons.receipt_long), label: 'Sipariş'),
          NavigationDestination(icon: Icon(Icons.history), label: 'Loglar'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
