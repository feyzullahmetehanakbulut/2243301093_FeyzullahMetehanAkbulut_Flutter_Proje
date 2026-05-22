import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../data/app_data.dart';
import '../../models/app_log.dart';
import '../admin/admin_home_page.dart';
import '../customer/customer_home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final mailController = TextEditingController();
  final sifreController = TextEditingController();

  bool sifreGorunsunMu = false;
  bool yukleniyor = false;

  Future<void> musteriGirisi() async {
    await girisYap(adminMi: false);
  }

  Future<void> adminGirisi() async {
    await girisYap(adminMi: true);
  }

  Future<void> girisYap({required bool adminMi}) async {
    final mail = mailController.text.trim();
    final sifre = sifreController.text.trim();

    if (mail.isEmpty || sifre.isEmpty) {
      mesajGoster('E-posta ve şifre boş bırakılamaz');
      return;
    }

    setState(() {
      yukleniyor = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mail,
        password: sifre,
      );

      if (!mounted) return;

      addLog(
        adminMi ? LogType.adminLogin : LogType.customerLogin,
        adminMi ? 'Admin / Üretici Giriş Yaptı' : 'Müşteri Giriş Yaptı',
        'E-posta: $mail\nZaman: ${DateTime.now().toLocal()}',
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              adminMi ? const AdminHomePage() : const CustomerHomePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      mesajGoster('Kod: ${e.code} - ${e.message}');
    } catch (e) {
      mesajGoster('Hata: $e');
    }

    if (mounted) {
      setState(() {
        yukleniyor = false;
      });
    }
  }

  void testHesabiniDoldur() {
    mailController.text = testEmail;
    sifreController.text = testPassword;
  }

  void uyeOlSayfasinaGit() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
      ),
    );
  }

  void mesajGoster(String mesaj) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mesaj)),
    );
  }

  @override
  void dispose() {
    mailController.dispose();
    sifreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Akvaryum Ürün Üretim ve Satış Sistemi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 35),

                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          'Giriş Yap',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 20),

                        TextField(
                          controller: mailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'E-posta',
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 15),

                        TextField(
                          controller: sifreController,
                          obscureText: !sifreGorunsunMu,
                          decoration: InputDecoration(
                            labelText: 'Şifre',
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                sifreGorunsunMu
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  sifreGorunsunMu = !sifreGorunsunMu;
                                });
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        yukleniyor
                            ? const CircularProgressIndicator()
                            : Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: musteriGirisi,
                                      child: const Text('Müşteri Girişi'),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: adminGirisi,
                                      child: const Text('Admin / Üretici Girişi'),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  TextButton(
                                    onPressed: uyeOlSayfasinaGit,
                                    child: const Text('Üye Ol'),
                                  ),

                                  TextButton(
                                    onPressed: testHesabiniDoldur,
                                    child: const Text('Test Hesabını Doldur'),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}