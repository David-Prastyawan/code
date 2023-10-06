part of 'add_note_cubit.dart';

// Kelas abstrak yang merupakan dasar untuk keadaan-keadaan dalam cubit AddNoteCubit.
sealed class AddNoteState {}

// Keadaan awal ketika tidak ada operasi yang sedang berlangsung.
final class AddNoteInitial extends AddNoteState {}

// Keadaan yang mengindikasikan sedang dalam proses menambahkan catatan.
final class AddNoteLoading extends AddNoteState {}

// Keadaan yang mengindikasikan penambahan catatan berhasil.
final class AddNoteSuccess extends AddNoteState {}

// Keadaan yang mengindikasikan penambahan catatan gagal, dengan pesan kesalahan tertentu.
final class AddNoteFailure extends AddNoteState {
  final String message;

  // Konstruktor untuk AddNoteFailure dengan parameter pesan kesalahan.
  AddNoteFailure({required this.message});
}
