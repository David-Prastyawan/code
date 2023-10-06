import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note_model.dart';

part 'add_note_state.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit() : super(AddNoteInitial());

  // Fungsi untuk menambahkan catatan.
  // Menerima objek NoteModel sebagai argumen.
  addNote(NoteModel note) async {
    // Memancarkan AddNoteLoading untuk mengindikasikan proses tambah catatan dimulai.
    emit(AddNoteLoading());
    try {
      // Mengakses kotak Hive untuk menyimpan catatan.
      var notesBox = Hive.box<NoteModel>(kHiveBoxName);

      // Menambahkan catatan ke dalam kotak Hive.
      await notesBox.add(note);

      // Memancarkan AddNoteSuccess untuk mengindikasikan tambah catatan berhasil.
      emit(AddNoteSuccess());
    } catch (e) {
      // Jika terjadi kesalahan, memancarkan AddNoteFailure dengan pesan kesalahan.
      emit(AddNoteFailure(message: e.toString()));
    }
  }
}
