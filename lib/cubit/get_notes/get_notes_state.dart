part of 'get_notes_cubit.dart';

// Kelas abstrak yang merupakan dasar untuk keadaan-keadaan dalam cubit GetNotesCubit.
sealed class GetNotesState {}

// Keadaan awal ketika tidak ada operasi pengambilan catatan yang sedang berlangsung.
final class GetNotesInitial extends GetNotesState {}

// Keadaan yang mengindikasikan sedang dalam proses pengambilan catatan.
final class GetNotesLoading extends GetNotesState {}

// Keadaan yang mengindikasikan pengambilan catatan berhasil dengan daftar catatan yang diambil.
final class GetNotesSuccess extends GetNotesState {
  final List<NoteModel> list; // Daftar catatan yang berhasil diambil.

  // Konstruktor untuk GetNotesSuccess dengan parameter daftar catatan.
  GetNotesSuccess({required this.list});
}

// Keadaan yang mengindikasikan pengambilan catatan gagal, dengan pesan kesalahan tertentu.
final class GetNotesFailure extends GetNotesState {
  final String
      errMessage; // Pesan kesalahan yang disertakan saat pengambilan gagal.

  // Konstruktor untuk GetNotesFailure dengan parameter pesan kesalahan.
  GetNotesFailure({required this.errMessage});
}
