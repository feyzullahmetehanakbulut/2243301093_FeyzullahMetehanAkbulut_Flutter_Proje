import 'package:flutter/material.dart';
import '../../data/app_data.dart';
import '../../models/product.dart';
import '../../widgets/page_template.dart';
import 'product_form_page.dart';

class AdminProductionPage extends StatelessWidget {
  final VoidCallback onRefresh;

  const AdminProductionPage({
    super.key,
    required this.onRefresh,
  });

  void openEditPage(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductFormPage(
          productToEdit: product,
          onSaved: onRefresh,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Üretim Paneli',
      child: ListView(
        children: products.map((product) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.inventory),
              title: Text(product.name),
              subtitle: Text('${product.status} - ${product.price.toStringAsFixed(0)} TL'),
              trailing: ElevatedButton(
                onPressed: () => openEditPage(context, product),
                child: const Text('Düzenle'),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
