import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/constants.dart';

import 'package:notes_app/models/note_model.dart';

part 'get_notes_state.dart';

// Mendefinisikan kelas GetNotesCubit yang merupakan Cubit untuk mendapatkan catatan.
class GetNotesCubit extends Cubit<GetNotesState> {
  GetNotesCubit() : super(GetNotesInitial());

  // Fungsi untuk mendapatkan catatan.
  getNotes() {
    emit(
        GetNotesLoading()); // Memancarkan GetNotesLoading untuk mengindikasikan proses pengambilan catatan dimulai.
    try {
      var box = Hive.box<NoteModel>(
          kHiveBoxName); // Mengakses kotak Hive yang berisi catatan.
      var lis = box.values
          .toList(); // Mengambil semua catatan dari kotak dan mengubahnya menjadi daftar.

      // Mengurutkan catatan berdasarkan tanggal dengan menggunakan formatter tanggal.
      lis.sort(
        (b, a) {
          var x = DateFormat.yMd().parse(a.date);
          var y = DateFormat.yMd().parse(b.date);
          return x.compareTo(y);
        },
      );

      // Membalik urutan catatan sehingga yang terbaru muncul pertama.
      lis = lis.reversed.toList();

      // Memancarkan GetNotesSuccess dengan daftar catatan yang telah diurutkan.
      emit(GetNotesSuccess(list: lis));
    } catch (e) {
      // Jika terjadi kesalahan, memancarkan GetNotesFailure dengan pesan kesalahan.
      emit(GetNotesFailure(errMessage: 'Failed : ${e.toString()}'));
    }
  }
}
