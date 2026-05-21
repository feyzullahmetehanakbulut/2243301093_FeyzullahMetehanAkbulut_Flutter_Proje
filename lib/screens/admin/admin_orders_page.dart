import 'package:flutter/material.dart';
import '../../data/app_data.dart';
import '../../models/app_log.dart';
import '../../models/order.dart';
import '../../widgets/page_template.dart';

class AdminOrdersPage extends StatelessWidget {
  final VoidCallback onRefresh;

  const AdminOrdersPage({
    super.key,
    required this.onRefresh,
  });

  void updateOrder(BuildContext context, Order order, String status) {
    order.status = status;

    addLog(
      LogType.orderStatus,
      'Sipariş $status',
      'Sipariş No: ${order.id}\n'
          'Müşteri: $testName\n'
          'Toplam: ${order.totalPrice.toStringAsFixed(0)} TL\n'
          'Adres: ${order.address}\n'
          'Durum: $status\n'
          'Ürünler:\n${order.items.map((e) => "- ${e.product.name} x${e.quantity}").join("\n")}',
    );

    globalOrders.removeWhere((item) => item.id == order.id);

    onRefresh();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sipariş $status ve listeden kaldırıldı')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Sipariş Yönetimi',
      child: globalOrders.isEmpty
          ? const Center(child: Text('Henüz gelen sipariş yok'))
          : ListView(
              children: globalOrders.map((order) {
                return Card(
                  child: ExpansionTile(
                    leading: const Icon(Icons.shopping_bag),
                    title: Text('Sipariş No: ${order.id}'),
                    subtitle: Text('Durum: ${order.status}\nAdres: ${order.address}'),
                    children: [
                      ...order.items.map((item) {
                        return ListTile(
                          title: Text(item.product.name),
                          subtitle: Text('Adet: ${item.quantity}'),
                          trailing: Text('${(item.product.price * item.quantity).toStringAsFixed(0)} TL'),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => updateOrder(context, order, 'Onaylandı'),
                                icon: const Icon(Icons.check),
                                label: const Text('Onayla'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () => updateOrder(context, order, 'Reddedildi'),
                                icon: const Icon(Icons.close),
                                label: const Text('Reddet'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
    );
  }
}
