import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';

class CustomAppBar extends StatelessWidget {
  // Konstruktor untuk menerima teks, ikon, dan callback onTap.
  CustomAppBar(
      {required this.text, required this.iconName, required this.onTap});

  String text; // Teks yang akan ditampilkan di app bar.
  IconData iconName; // Ikon yang akan ditampilkan di app bar.
  void Function()?
      onTap; // Callback yang akan dijalankan saat ikon di app bar diklik.

  @override
  AppBar build(BuildContext context) {
    return AppBar(
      toolbarHeight: 60, // Tinggi app bar.
      title: Padding(
        padding: const EdgeInsets.only(
          top: 18,
          right: 18,
        ),
        child: Text(
          text, // Menampilkan teks di app bar.
          style: const TextStyle(
            fontSize: 26,
            color: kAppBarSecondaryColor,
          ),
        ),
      ),
      backgroundColor: kAppBarPrimaryColor, // Warna latar belakang app bar.
      elevation: 0, // Menghapus bayangan app bar.
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            top: 12.0,
            right: 18.0,
          ),
          child: GestureDetector(
            onTap: onTap, // Menetapkan callback onTap ke GestureDetector.
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 42,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color:
                        kSearchButtonBackgroundColor, // Warna latar belakang ikon pencarian.
                    borderRadius: BorderRadius.circular(
                        16), // Membuat sudut bulat untuk latar belakang ikon.
                  ),
                ),
                Icon(
                  iconName, // Menampilkan ikon di dalam Stack.
                  size: 25,
                  color: kAppBarSecondaryColor, // Warna ikon di app bar.
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
