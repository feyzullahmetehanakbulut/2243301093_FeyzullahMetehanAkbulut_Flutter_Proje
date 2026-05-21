import 'package:flutter/material.dart';
import '../../data/app_data.dart';
import '../../models/app_log.dart';
import '../../utils/app_helpers.dart';
import '../../widgets/page_template.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  List<AppLog> sortedLogs(LogType type) {
    final filtered = appLogs.where((log) => log.type == type).toList();
    filtered.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return filtered;
  }

  void openLogDetail(BuildContext context, AppLog log) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(log.title),
          content: SingleChildScrollView(
            child: Text('${formatDate(log.dateTime)}\n\n${log.detail}'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Kapat'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final orderCreatedLogs = sortedLogs(LogType.orderCreated);
    final orderStatusLogs = sortedLogs(LogType.orderStatus);

    return PageTemplate(
      title: 'Log Kayıtları',
      child: ListView(
        children: [
          const Text(
            'Müşteri Sipariş Oluşturmaları',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (orderCreatedLogs.isEmpty)
            const Card(
              child: ListTile(
                title: Text('Henüz müşteri sipariş kaydı yok'),
              ),
            )
          else
            ...orderCreatedLogs.map((log) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: Text(log.title),
                  subtitle: Text(formatDate(log.dateTime)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => openLogDetail(context, log),
                ),
              );
            }),
          const SizedBox(height: 24),
          const Text(
            'Sipariş Onay / Red Kayıtları',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (orderStatusLogs.isEmpty)
            const Card(
              child: ListTile(
                title: Text('Henüz sipariş onay/red kaydı yok'),
              ),
            )
          else
            ...orderStatusLogs.map((log) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.verified),
                  title: Text(log.title),
                  subtitle: Text(formatDate(log.dateTime)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => openLogDetail(context, log),
                ),
              );
            }),
        ],
      ),
    );
  }
}
