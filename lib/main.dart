import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/cubit/edit_note/editnote_cubit.dart';
import 'package:notes_app/cubit/get_notes/get_notes_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/note_bloc_observer.dart';
import 'package:notes_app/screens/edit_screen.dart';
import 'package:notes_app/screens/home_screen.dart';

// Fungsi utama untuk menjalankan aplikasi Flutter.
void main() async {
  Bloc.observer =
      NoteBlocObserver(); // Menggunakan NoteBlocObserver untuk memantau Blocs.
  await Hive.initFlutter(); // Inisialisasi Hive untuk Flutter.
  Hive.registerAdapter(
      NoteModelAdapter()); // Mendaftarkan adapter untuk model NoteModel.
  await Hive.openBox<NoteModel>(
      kHiveBoxName); // Membuka kotak Hive dengan tipe NoteModel.

  runApp(const NotesApp()); // Menjalankan aplikasi Flutter NotesApp.
}

// Kelas utama aplikasi yang merupakan StatelessWidget.
class NotesApp extends StatelessWidget {
  const NotesApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                GetNotesCubit()), // Memberikan GetNotesCubit sebagai provider Bloc.
        BlocProvider(
            create: (context) =>
                EditnoteCubit()), // Memberikan EditnoteCubit sebagai provider Bloc.
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Menyembunyikan banner debug.
        theme: ThemeData.dark(), // Mengatur tema aplikasi menjadi tema gelap.
        initialRoute:
            kHomeScreen, // Rute awal yang ditentukan sebagai kHomeScreen.
        routes: {
          kHomeScreen: (context) =>
              const HomeScreen(), // Rute untuk HomeScreen.
          kEditScreen: (context) => EditScreen() // Rute untuk EditScreen.
        },
      ),
    );
  }
}
