import '../models/app_log.dart';
import '../models/order.dart';
import '../models/product.dart';

const String testEmail = 'Test@test.com';
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
  appLogs.add(
    AppLog(
      type: type,
      title: title,
      detail: detail,
      dateTime: DateTime.now(),
    ),
  );
}
