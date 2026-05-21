enum LogType {
  orderCreated,
  orderStatus,
}

class AppLog {
  final LogType type;
  final String title;
  final String detail;
  final DateTime dateTime;

  AppLog({
    required this.type,
    required this.title,
    required this.detail,
    required this.dateTime,
  });
}
