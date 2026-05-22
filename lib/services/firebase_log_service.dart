import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseLogService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  // MÜŞTERİ GİRİŞİ
  static Future<void> musteriGirisiLog({
    required String email,
  }) async {
    await _db.collection('loglar').add({
      'tip': 'musteri_girisi',
      'baslik': 'Müşteri Girişi',
      'email': email,
      'detay':
          '$email adresli kullanıcı müşteri girişi yaptı.',
      'tarih': FieldValue.serverTimestamp(),
    });
  }

  // ADMİN GİRİŞİ
  static Future<void> adminGirisiLog({
    required String email,
  }) async {
    await _db.collection('loglar').add({
      'tip': 'admin_girisi',
      'baslik': 'Admin Girişi',
      'email': email,
      'detay':
          '$email adresli kullanıcı admin girişi yaptı.',
      'tarih': FieldValue.serverTimestamp(),
    });
  }

  // KAYIT OLMA
  static Future<void> kayitOlmaLog({
    required String adSoyad,
    required String email,
  }) async {
    await _db.collection('loglar').add({
      'tip': 'kayit_olma',
      'baslik': 'Yeni Kullanıcı Kaydı',
      'adSoyad': adSoyad,
      'email': email,
      'detay':
          '$adSoyad isimli kullanıcı kayıt oldu.',
      'tarih': FieldValue.serverTimestamp(),
    });
  }

  // MÜŞTERİ SİPARİŞ OLUŞTURMA
  static Future<void> musteriSiparisiLog({
    required String email,
    required String adres,
    required double toplamTutar,
    required List<Map<String, dynamic>> urunler,
  }) async {
    await _db.collection('loglar').add({
      'tip': 'musteri_siparisi',
      'baslik': 'Yeni Sipariş Oluşturuldu',
      'email': email,
      'adres': adres,
      'toplamTutar': toplamTutar,
      'urunler': urunler,
      'detay':
          '$email adresli müşteri yeni sipariş oluşturdu.',
      'tarih': FieldValue.serverTimestamp(),
    });
  }

  // SİPARİŞ ONAY / RED
  static Future<void> siparisDurumLog({
    required String siparisId,
    required String durum,
    required double toplamTutar,
  }) async {
    await _db.collection('loglar').add({
      'tip': 'siparis_durumu',
      'baslik': 'Sipariş Güncellendi',
      'siparisId': siparisId,
      'durum': durum,
      'toplamTutar': toplamTutar,
      'detay':
          'Sipariş $durum olarak güncellendi.',
      'tarih': FieldValue.serverTimestamp(),
    });
  }
}