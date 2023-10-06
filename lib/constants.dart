import 'package:flutter/material.dart';
import 'dart:math';

// Nama-nama konstan untuk nama halaman, nama kotak Hive, dan warna-warna.
const kHomeScreen = 'HomeScreen';
const kEditScreen = 'EditScreen';
const kHiveBoxName = 'Notes Box';
const kAppBarPrimaryColor = Color(0xFF303030);
const kSearchButtonBackgroundColor = Color(0xFF3B3B3B);
const kAppBarSecondaryColor = Colors.white70;

// Fungsi untuk menghasilkan warna acak dalam bentuk heksadesimal.
String generateRandomColor() {
  Random random = Random();

  // Tentukan rentang nilai RGB yang dapat diterima di sekitar warna yang diberikan
  int minRange = 50;
  int maxRange = 80;

  // Generate nilai RGB acak dalam rentang yang dapat diterima
  int r = _generateRandomInRange(random, _hexToR('FFCD7A'), minRange, maxRange);
  int g = _generateRandomInRange(random, _hexToG('FFCD7A'), minRange, maxRange);
  int b = _generateRandomInRange(random, _hexToB('FFCD7A'), minRange, maxRange);

  String hexColor =
      _rgbToHex(r, g, b); // Ubah nilai RGB ke format heksadesimal.

  return hexColor
      .toUpperCase(); // Kembalikan warna dalam format heksadesimal yang diubah ke huruf besar.
}

// Fungsi untuk menghasilkan nilai acak dalam rentang tertentu berdasarkan nilai dan batasan.
int _generateRandomInRange(
    Random random, int value, int minRange, int maxRange) {
  int minValue = max(0, value - minRange);
  int maxValue = min(255, value + maxRange);
  return minValue + random.nextInt(maxValue - minValue + 1);
}

// Fungsi untuk mengambil nilai merah (R) dari kode warna heksadesimal.
int _hexToR(String hex) {
  return int.parse(hex.substring(0, 2), radix: 16);
}

// Fungsi untuk mengambil nilai hijau (G) dari kode warna heksadesimal.
int _hexToG(String hex) {
  return int.parse(hex.substring(2, 4), radix: 16);
}

// Fungsi untuk mengambil nilai biru (B) dari kode warna heksadesimal.
int _hexToB(String hex) {
  return int.parse(hex.substring(4, 6), radix: 16);
}

// Fungsi untuk mengubah nilai RGB menjadi format warna heksadesimal.
String _rgbToHex(int r, int g, int b) {
  return '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}';
}
