import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteBlocObserver implements BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    debugPrint('Created : ${bloc.toString()}');
    // Metode ini dipanggil ketika suatu Bloc baru dibuat.
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // Metode ini dipanggil ketika suatu peristiwa (event) diterima oleh Bloc.
    // Anda dapat melakukan tindakan yang sesuai dengan event yang diterima di sini.
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // Metode ini dipanggil ketika terjadi kesalahan dalam Bloc.
    // Anda dapat menangani kesalahan atau mencatatnya di sini.
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    debugPrint('Change : ${change.toString()}');
    // Metode ini dipanggil ketika ada perubahan (change) dalam Bloc.
    // Anda dapat memantau perubahan-perubahan tersebut di sini.
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // Metode ini dipanggil ketika suatu Bloc berpindah ke keadaan (state) atau perubahan tertentu.
    // Anda dapat menangani transisi Bloc di sini.
  }

  @override
  void onClose(BlocBase bloc) {
    debugPrint('Closed : ${bloc.toString()}');
    // Metode ini dipanggil ketika suatu Bloc ditutup (closed).
    // Anda dapat melakukan tindakan pembersihan atau pembebasan sumber daya di sini.
  }
}
