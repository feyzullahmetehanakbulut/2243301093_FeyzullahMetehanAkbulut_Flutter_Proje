import 'package:flutter/material.dart';

class RoleInfoCard extends StatelessWidget {
  final bool isAdmin;

  const RoleInfoCard({
    super.key,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isAdmin ? Colors.orange.shade50 : Colors.teal.shade50,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        isAdmin
            ? 'Admin hesabı: ürün ekleyebilir, düzenleyebilir ve siparişleri onaylayıp reddedebilir.'
            : 'Müşteri hesabı: ürünleri sepete ekleyebilir, favorilere alabilir ve sipariş oluşturabilir.',
      ),
    );
  }
}
