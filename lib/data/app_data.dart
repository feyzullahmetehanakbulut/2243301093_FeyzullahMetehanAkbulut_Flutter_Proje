import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:flutter/foundation.dart';
import '../models/app_log.dart';
import '../models/order.dart';
import '../models/product.dart';

const String testEmail = 'test@test.com';
const String testPassword = '123456';
const String testName = 'Feyzullah';

final List<Product> products = [
  Product(
    id: '1',
    name: 'Akvaryum Filtresi',
    price: 350,
    description: 'Orta boy akvaryumlar için iç filtre.',
    status: 'Satışta',
  ),
  Product(
    id: '2',
    name: 'Balık Yemi',
    price: 120,
    description: 'Tropikal balıklar için yem.',
    status: 'Stokta',
  ),
  Product(
    id: '3',
    name: 'LED Akvaryum Aydınlatması',
    price: 480,
    description: 'Enerji tasarruflu LED sistem.',
    status: 'Üretimde',
  ),
];

final List<Order> globalOrders = [];
final List<AppLog> appLogs = [];

void addLog(LogType type, String title, String detail) {
  final dateTime = DateTime.now();
  appLogs.add(
    AppLog(
      type: type,
      title: title,
      detail: detail,
      dateTime: dateTime,
    ),
  );

  () async {
    try {
      await FirebaseFirestore.instance.collection('logs').add({
        'type': type.name,
        'title': title,
        'detail': detail,
        'dateTime': dateTime.toIso8601String(),
      });
    } catch (e) {
      debugPrint('Firestore log kaydetme hatası: $e');
    }
  }();
}
