import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/cubit/add_note/add_note_cubit.dart';
import 'package:notes_app/cubit/get_notes/get_notes_cubit.dart';
import 'package:notes_app/models/note_model.dart';

class AddNoteBottomSheet extends StatefulWidget {
  const AddNoteBottomSheet({super.key});

  @override
  State<AddNoteBottomSheet> createState() => _AddNoteBottomSheetState();
}

class _AddNoteBottomSheetState extends State<AddNoteBottomSheet> {
  // Controller untuk mengelola teks judul dan konten catatan.
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  // GlobalKey untuk mengontrol dan memvalidasi form.
  final GlobalKey<FormState> _formKey = GlobalKey();

  // Variabel untuk menyimpan warna yang dipilih dalam ColorPicker.
  Color screenPickerColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNoteCubit(),
      child: FractionallySizedBox(
        heightFactor: 0.55,
        child: BlocConsumer<AddNoteCubit, AddNoteState>(
          listener: (context, state) {
            if (state is AddNoteFailure) {
              // Menampilkan pesan kesalahan jika penambahan catatan gagal.
              Fluttertoast.showToast(
                msg: 'Failed Adding ${state.message}',
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
            if (state is AddNoteSuccess) {
              // Menampilkan pesan sukses dan menutup bottom sheet setelah catatan ditambahkan.
              Fluttertoast.showToast(
                msg: 'Added Successfully',
                toastLength: Toast.LENGTH_SHORT,
                timeInSecForIosWeb: 1,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return AbsorbPointer(
              absorbing: state is AddNoteLoading,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Form(
                    key: _formKey,
                    child: Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      runSpacing: 20,
                      children: [
                        // Input field untuk judul catatan.
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: formValidation,
                          controller: titleController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Title',
                            hintStyle: TextStyle(
                              color: Colors.tealAccent,
                              fontSize: 18,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Input field untuk konten catatan.
                        TextFormField(
                          controller: contentController,
                          validator: formValidation,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          maxLines: 9,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Content',
                            hintStyle: TextStyle(
                              color: Colors.tealAccent,
                              fontSize: 18,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // ColorPicker untuk memilih warna catatan.
                        Card(
                          elevation: 12,
                          color: Colors.black12,
                          child: SizedBox(
                            width: double.infinity,
                            child: ColorPicker(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 25,
                              ),
                              enableShadesSelection: true,
                              pickersEnabled: const <ColorPickerType, bool>{
                                ColorPickerType.both: false,
                                ColorPickerType.primary: true,
                                ColorPickerType.accent: false,
                                ColorPickerType.bw: false,
                                ColorPickerType.custom: false,
                                ColorPickerType.wheel: false,
                              },
                              // Menggunakan screenPickerColor sebagai warna awal.
                              color: screenPickerColor,
                              // Mengupdate screenPickerColor saat warna dipilih.
                              onColorChanged: (Color color) =>
                                  setState(() => screenPickerColor = color),
                              width: 44,
                              height: 44,
                              borderRadius: 22,
                              heading: Text(
                                'Select color',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              subheading: Text(
                                'Select color shade',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ),
                        ),
                        // Tombol kustom untuk menambahkan catatan.
                        CustomButton(
                          formKey: _formKey,
                          titleController: titleController,
                          contentController: contentController,
                          screenPickerColor: screenPickerColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Fungsi validasi sederhana untuk memeriksa apakah input kosong.
  String? formValidation(value) {
    if (value?.isEmpty ?? true) {
      return 'Field is required';
    }
    return null;
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.titleController,
    required this.contentController,
    required this.screenPickerColor,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController titleController;
  final TextEditingController contentController;
  final Color screenPickerColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: BlocBuilder<AddNoteCubit, AddNoteState>(
        builder: (context, state) {
          return ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Membuat objek NoteModel dari input pengguna.
                NoteModel note = NoteModel(
                  title: titleController.text,
                  content: contentController.text,
                  date: DateFormat.yMd().add_jm().format(DateTime.now()),
                  color: screenPickerColor.withOpacity(221 / 256).value,
                );
                // Memanggil fungsi untuk menambahkan catatan.
                BlocProvider.of<AddNoteCubit>(context).addNote(note);
                // Memanggil fungsi untuk memperbarui daftar catatan.
                BlocProvider.of<GetNotesCubit>(context).getNotes();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.tealAccent,
            ),
            child: state is AddNoteLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  )
                : const Text(
                    'Add',
                    style: TextStyle(color: Colors.black87),
                  ),
          );
        },
      ),
    );
  }
}
