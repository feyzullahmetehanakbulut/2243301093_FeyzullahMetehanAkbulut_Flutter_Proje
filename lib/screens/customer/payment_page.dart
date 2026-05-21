import 'package:flutter/material.dart';
import '../../models/cart_item.dart';

class PaymentPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final double totalPrice;
  final void Function(String address) onPaymentCompleted;

  const PaymentPage({
    super.key,
    required this.cartItems,
    required this.totalPrice,
    required this.onPaymentCompleted,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final nameController = TextEditingController();
  final cardController = TextEditingController();
  final expiryController = TextEditingController();
  final cvcController = TextEditingController();
  final addressController = TextEditingController();

  void completePayment() {
    final card = cardController.text.trim();
    final expiry = expiryController.text.trim();
    final cvc = cvcController.text.trim();
    final address = addressController.text.trim();

    if (nameController.text.trim().isEmpty ||
        address.isEmpty ||
        card.length != 16 ||
        int.tryParse(card) == null ||
        expiry.isEmpty ||
        cvc.length != 3 ||
        int.tryParse(cvc) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Adres, 16 haneli kart numarası, son kullanma tarihi ve 3 haneli CVC girilmelidir'),
        ),
      );
      return;
    }

    widget.onPaymentCompleted(address);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ödeme tamamlandı, sipariş admine gönderildi')),
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    nameController.dispose();
    cardController.dispose();
    expiryController.dispose();
    cvcController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ödeme Sayfası'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Sipariş Özeti',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...widget.cartItems.map((item) {
              return Card(
                child: ListTile(
                  title: Text(item.product.name),
                  subtitle: Text('Adet: ${item.quantity}'),
                  trailing: Text('${(item.product.price * item.quantity).toStringAsFixed(0)} TL'),
                ),
              );
            }),
            const SizedBox(height: 12),
            TextField(
              controller: addressController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Teslimat Adresi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Kart Üzerindeki İsim',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: cardController,
              maxLength: 16,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: '16 Haneli Kart Numarası',
                border: OutlineInputBorder(),
                counterText: '',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: expiryController,
                    decoration: const InputDecoration(
                      labelText: 'Son Kullanma Tarihi',
                      hintText: 'AA/YY',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: cvcController,
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'CVC',
                      border: OutlineInputBorder(),
                      counterText: '',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Toplam: ${widget.totalPrice.toStringAsFixed(0)} TL',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: completePayment,
                icon: const Icon(Icons.payment),
                label: const Text('Ödemeyi Tamamla'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
