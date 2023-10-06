import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/cubit/get_notes/get_notes_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/screens/edit_screen.dart';

class CustomListTile extends StatefulWidget {
  const CustomListTile({
    super.key,
  });

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    // Memanggil metode getNotes dari GetNotesCubit untuk mendapatkan daftar catatan.
    BlocProvider.of<GetNotesCubit>(context).getNotes();
    List<NoteModel> notes = []; // Inisialisasi daftar catatan.

    return BlocBuilder<GetNotesCubit, GetNotesState>(
      builder: (context, state) {
        if (state is GetNotesSuccess) {
          notes = state.list; // Mengisi daftar catatan dengan data dari state.
        }

        return Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 8.0),
          child: state is GetNotesLoading
              ? const Center(
                  child:
                      CircularProgressIndicator(), // Menampilkan indikator loading jika sedang memuat data.
                )
              : ListView.builder(
                  itemCount: notes.length,
                  physics: const BouncingScrollPhysics(),
                  itemExtent: 240,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(18, 6, 18, 6),
                      child: GestureDetector(
                        onTap: () {
                          // Menavigasi ke EditScreen dengan membawa data catatan yang dipilih.
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditScreen(
                                  note: notes[index],
                                ),
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(32, 36, 20, 22),
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color(notes[index]
                                  .color), // Warna latar belakang berdasarkan catatan.
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 12,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 40.0),
                                          child: Text(
                                            notes[index].title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 50.0),
                                          child: Text(
                                            notes[index].content,
                                            maxLines: 4,
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: IconButton(
                                      onPressed: () async {
                                        try {
                                          // Menghapus catatan dari Hive.
                                          await Hive.box<NoteModel>(
                                                  kHiveBoxName)
                                              .delete(notes[index].key);
                                          setState(
                                              () {}); // Memperbarui tampilan setelah menghapus catatan.
                                        } on Exception catch (e) {
                                          debugPrint(e.toString());
                                        }
                                      },
                                      icon: const Icon(CupertinoIcons
                                          .trash_fill), // Ikon hapus.
                                      color: Colors.black,
                                      iconSize: 30,
                                    ),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  notes[index]
                                      .date, // Menampilkan tanggal catatan.
                                  style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 15,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
