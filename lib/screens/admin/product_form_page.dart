import 'package:flutter/material.dart';
import '../../data/app_data.dart';
import '../../models/product.dart';
import '../../widgets/page_template.dart';

class ProductFormPage extends StatefulWidget {
  final Product? productToEdit;
  final VoidCallback onSaved;

  const ProductFormPage({
    super.key,
    this.productToEdit,
    required this.onSaved,
  });

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController stockController;
  late TextEditingController descriptionController;

  String selectedStatus = 'Satışta';

  @override
  void initState() {
    super.initState();

    final product = widget.productToEdit;

    nameController = TextEditingController(text: product?.name ?? '');
    priceController = TextEditingController(text: product?.price.toStringAsFixed(0) ?? '');
    stockController = TextEditingController(text: '10');
    descriptionController = TextEditingController(text: product?.description ?? '');
    selectedStatus = product?.status ?? 'Satışta';
  }

  void saveProduct() {
    final name = nameController.text.trim();
    final price = double.tryParse(priceController.text.trim()) ?? 0;
    final stock = stockController.text.trim();
    final description = descriptionController.text.trim();

    if (name.isEmpty || price <= 0 || stock.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen ürün bilgilerini doğru girin')),
      );
      return;
    }

    if (widget.productToEdit == null) {
      products.add(
        Product(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: name,
          price: price,
          description: description,
          status: selectedStatus,
        ),
      );
    } else {
      widget.productToEdit!
        ..name = name
        ..price = price
        ..description = description
        ..status = selectedStatus;
    }

    widget.onSaved();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.productToEdit == null ? 'Ürün üretim ekranına eklendi' : 'Ürün güncellendi'),
      ),
    );

    if (widget.productToEdit != null) {
      Navigator.pop(context);
    } else {
      nameController.clear();
      priceController.clear();
      stockController.clear();
      descriptionController.clear();
      setState(() => selectedStatus = 'Satışta');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: widget.productToEdit == null ? 'Ürün Ekle' : 'Ürün Düzenle',
      child: ListView(
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Ürün Adı', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Fiyat', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: stockController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Stok Adedi', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: selectedStatus,
            decoration: const InputDecoration(labelText: 'Üretim Durumu', border: OutlineInputBorder()),
            items: const [
              DropdownMenuItem(value: 'Üretimde', child: Text('Üretimde')),
              DropdownMenuItem(value: 'Satışta', child: Text('Satışta')),
              DropdownMenuItem(value: 'Stokta Az', child: Text('Stokta Az')),
              DropdownMenuItem(value: 'Tükendi', child: Text('Tükendi')),
            ],
            onChanged: (value) {
              setState(() => selectedStatus = value!);
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: descriptionController,
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'Açıklama', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: saveProduct,
            icon: const Icon(Icons.save),
            label: Text(widget.productToEdit == null ? 'Ürünü Kaydet' : 'Değişiklikleri Kaydet'),
          ),
        ],
      ),
    );
  }
}
