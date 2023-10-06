import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note_model.dart';

part 'editnote_state.dart';

// Mendefinisikan kelas EditnoteCubit yang merupakan Cubit untuk mengedit catatan.
class EditnoteCubit extends Cubit<EditnoteState> {
  EditnoteCubit() : super(EditnoteInitial());

  // Fungsi untuk mengedit catatan dengan kunci (key) dan objek NoteModel baru.
  editNote(
    dynamic key, // Kunci catatan yang akan diedit.
    NoteModel note, // Objek catatan baru yang akan menggantikan catatan lama.
  ) async {
    emit(
        EditnoteLoading()); // Memancarkan EditnoteLoading untuk mengindikasikan proses pengeditan dimulai.
    try {
      // Menggunakan Hive untuk memperbarui catatan di dalam kotak Hive dengan kunci yang diberikan.
      await Hive.box<NoteModel>(kHiveBoxName).put(key, note);
      emit(
          EditnoteSuccess()); // Memancarkan EditnoteSuccess untuk mengindikasikan pengeditan catatan berhasil.
    } catch (e) {
      // Jika terjadi kesalahan, memancarkan EditnoteFailure dengan pesan kesalahan.
      emit(EditnoteFailure(message: 'Failed : ${e.toString()}'));
    }
  }
}
