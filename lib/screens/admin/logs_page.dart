import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/app_log.dart';
import '../../utils/app_helpers.dart';
import '../../widgets/page_template.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

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
    return PageTemplate(
      title: 'Log Kayıtları',
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('logs')
            .orderBy('dateTime', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Loglar yüklenirken hata oluştu: ${snapshot.error}'),
            );
          }

          final docs = snapshot.data?.docs ?? [];
          final allLogs = docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            
            LogType logType;
            try {
              logType = LogType.values.firstWhere((e) => e.name == data['type']);
            } catch (_) {
              logType = LogType.orderCreated;
            }

            return AppLog(
              type: logType,
              title: data['title'] ?? '',
              detail: data['detail'] ?? '',
              dateTime: DateTime.tryParse(data['dateTime'] ?? '') ?? DateTime.now(),
            );
          }).toList();

          final orderCreatedLogs = allLogs.where((log) => log.type == LogType.orderCreated).toList();
          final orderStatusLogs = allLogs.where((log) => log.type == LogType.orderStatus).toList();
          final loginLogs = allLogs.where((log) => log.type == LogType.customerLogin || log.type == LogType.adminLogin).toList();
          final registerLogs = allLogs.where((log) => log.type == LogType.userRegister).toList();

          return ListView(
            children: [
              // MÜŞTERİ SİPARİŞ OLUŞTURMALARI
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
                      leading: const Icon(Icons.shopping_cart, color: Colors.blue),
                      title: Text(log.title),
                      subtitle: Text(formatDate(log.dateTime)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => openLogDetail(context, log),
                    ),
                  );
                }),
              const SizedBox(height: 24),

              // SİPARİŞ ONAY / RED KAYITLARI
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
                  final isApproved = log.title.contains('Onaylandı') || log.detail.contains('Onaylandı');
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        isApproved ? Icons.check_circle : Icons.cancel,
                        color: isApproved ? Colors.green : Colors.red,
                      ),
                      title: Text(log.title),
                      subtitle: Text(formatDate(log.dateTime)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => openLogDetail(context, log),
                    ),
                  );
                }),
              const SizedBox(height: 24),

              // GİRİŞ KAYITLARI
              const Text(
                'Kullanıcı Giriş Kayıtları',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (loginLogs.isEmpty)
                const Card(
                  child: ListTile(
                    title: Text('Henüz giriş kaydı yok'),
                  ),
                )
              else
                ...loginLogs.map((log) {
                  final isAdmin = log.type == LogType.adminLogin;
                  return Card(
                    child: ListTile(
                      leading: Icon(
                        isAdmin ? Icons.admin_panel_settings : Icons.person,
                        color: isAdmin ? Colors.purple : Colors.teal,
                      ),
                      title: Text(log.title),
                      subtitle: Text(formatDate(log.dateTime)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => openLogDetail(context, log),
                    ),
                  );
                }),
              const SizedBox(height: 24),

              // YENİ ÜYE KAYITLARI
              const Text(
                'Yeni Üye Kayıtları',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              if (registerLogs.isEmpty)
                const Card(
                  child: ListTile(
                    title: Text('Henüz yeni üye kaydı yok'),
                  ),
                )
              else
                ...registerLogs.map((log) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.person_add, color: Colors.orange),
                      title: Text(log.title),
                      subtitle: Text(formatDate(log.dateTime)),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => openLogDetail(context, log),
                    ),
                  );
                }),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
