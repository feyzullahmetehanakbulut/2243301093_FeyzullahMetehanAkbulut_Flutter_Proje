import 'package:flutter/material.dart';
import '../../data/app_data.dart';
import '../../screens/auth/login_page.dart';
import '../../widgets/page_template.dart';
import '../../widgets/profile_menu_item.dart';
import '../../widgets/role_info_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  final bool isAdmin;
  final VoidCallback onGoOrders;
  final VoidCallback onGoFavorites;
  final VoidCallback onGoHistory;

  const ProfilePage({
    super.key,
    required this.isAdmin,
    required this.onGoOrders,
    required this.onGoFavorites,
    required this.onGoHistory,
  });

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Profilim',
      child: SingleChildScrollView(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 42,
              child: Text('F', style: TextStyle(fontSize: 32)),
            ),
            const SizedBox(height: 12),
            const Text(
              testName,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(isAdmin ? 'Admin / Üretici' : 'Müşteri'),
            const SizedBox(height: 20),
            RoleInfoCard(isAdmin: isAdmin),
            const SizedBox(height: 20),
            ProfileMenuItem(
              title: isAdmin ? 'Sipariş Yönetimi' : 'Siparişlerim',
              icon: Icons.receipt_long,
              onTap: onGoOrders,
            ),
            ProfileMenuItem(
              title: isAdmin ? 'Üretim Paneli' : 'Favorilerim',
              icon: isAdmin ? Icons.factory : Icons.favorite,
              onTap: onGoFavorites,
            ),
            ProfileMenuItem(
              title: isAdmin ? 'Log Kayıtları' : 'Sipariş Geçmişi',
              icon: Icons.history,
              onTap: onGoHistory,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child:OutlinedButton.icon(
                onPressed: () async {
                await FirebaseAuth.instance.signOut();
                 Navigator.pushReplacement(
                 context,
                   MaterialPageRoute(builder: (_) => const LoginPage()),
                 );
                },
                icon: const Icon(Icons.logout),
                label: const Text('Çıkış Yap'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
