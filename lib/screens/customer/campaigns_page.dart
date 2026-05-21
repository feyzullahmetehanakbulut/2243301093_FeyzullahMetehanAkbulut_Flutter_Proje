import 'package:flutter/material.dart';
import '../../widgets/page_template.dart';

class CampaignsPage extends StatelessWidget {
  const CampaignsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Kampanyalar',
      child: ListView(
        children: [
          Container(
            height: 170,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [Colors.teal.shade400, Colors.teal.shade700],
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Text(
                  'YAZ KAMPANYASI',
                  style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Akvaryum ürünlerinde özel fırsatlar',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const CampaignCard(title: 'Filtre Sistemleri', discount: '%20'),
          const CampaignCard(title: 'LED Aydınlatmalar', discount: '%15'),
          const CampaignCard(title: 'Balık Yemleri', discount: '%10'),
        ],
      ),
    );
  }
}

class CampaignCard extends StatelessWidget {
  final String title;
  final String discount;

  const CampaignCard({
    super.key,
    required this.title,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.local_offer, color: Colors.teal),
        title: Text(title),
        subtitle: const Text('Sınırlı süreli kampanya'),
        trailing: Text(
          discount,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ),
    );
  }
}
