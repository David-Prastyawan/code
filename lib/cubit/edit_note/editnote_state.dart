part of 'editnote_cubit.dart';

// Kelas abstrak yang merupakan dasar untuk keadaan-keadaan dalam cubit EditnoteCubit.
@immutable
sealed class EditnoteState {}

// Keadaan awal ketika tidak ada operasi pengeditan catatan yang sedang berlangsung.
final class EditnoteInitial extends EditnoteState {}

// Keadaan yang mengindikasikan sedang dalam proses pengeditan catatan.
final class EditnoteLoading extends EditnoteState {}

// Keadaan yang mengindikasikan pengeditan catatan berhasil.
final class EditnoteSuccess extends EditnoteState {}

// Keadaan yang mengindikasikan pengeditan catatan gagal, dengan pesan kesalahan tertentu.
final class EditnoteFailure extends EditnoteState {
  final String message;

  // Konstruktor untuk EditnoteFailure dengan parameter pesan kesalahan.
  EditnoteFailure({required this.message});
}
