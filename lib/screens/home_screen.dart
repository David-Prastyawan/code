import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubit/get_notes/get_notes_cubit.dart';
import 'package:notes_app/views/add_note_bottom_sheet.dart';
import 'package:notes_app/views/custom_app_bar.dart';
import 'package:notes_app/views/custom_list_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Tombol tindakan mengambang (Floating Action Button) untuk menambah catatan.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Menampilkan bottom sheet untuk menambahkan catatan.
          showModalBottomSheet(
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(50.0),
              ),
            ),
            context: context,
            builder: (context) {
              // Mengembalikan widget AddNoteBottomSheet sebagai isi dari bottom sheet.
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: const AddNoteBottomSheet(),
              );
            },
          );
        },
        child: const Icon(Icons.add), // Icon tambah pada tombol mengambang.
      ),
      appBar: CustomAppBar(
        text: 'Notes', // Teks yang ditampilkan di app bar.
        iconName: Icons.search, // Icon pencarian di app bar.
        onTap:
            () {}, // Callback yang akan dijalankan ketika icon di app bar diklik.
      ).build(
          context), // Membangun app bar sesuai dengan konfigurasi yang diberikan.
      body: const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: CustomListTile(), // Widget untuk menampilkan daftar catatan.
      ),
    );
  }
}
