import 'package:flutter/material.dart';
import 'screens/auth/login_page.dart';

void main() {
  runApp(const AquariumApp());
}

class AquariumApp extends StatelessWidget {
  const AquariumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akvaryum Üretim ve Satış',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
