import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymapp/IconPicker/iconpicker.dart';
import 'package:gymapp/classes/ExerciseClass.dart';

class AddExercise_class extends ConsumerStatefulWidget {
  const AddExercise_class({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddExercise_classState();
}

final colorProvider = StateProvider<Color>((ref) => Colors.primaries.last);
final iconProvider = StateProvider<IconData>((ref) => Icons.favorite);

class _AddExercise_classState extends ConsumerState<AddExercise_class> {
  //Controllers
  final nameController = TextEditingController();

  //vars
  String? error;

  //Metodos
  _onsave() {
    final name = nameController.text.trim();
    if (name.isNotEmpty) {
      final finalcolor = ref.read(colorProvider.state);
      final retornado = Exercise(
          day: "Today",
          name: name,
          weight: 999,
          color: finalcolor.state,
          icono: ref.read(iconProvider));
      Navigator.of(context).pop(retornado);
    } else {}
  }

  Future<void> _changeIcon() async {
    final result = await showDialog(
      context: context,
      builder: (_) => IconPicker(),
    );

    if (result != ref.read(iconProvider)) {
      print(iconProvider.state.toString());
      ref.watch(iconProvider.state).state = result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        height: MediaQuery.of(context).size.height / 1.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: ref.read(colorProvider),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      child: Icon(
                        ref.read(iconProvider),
                        size: 50,
                      ),
                      onTap: () {
                        _changeIcon();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextField(
                        controller: nameController,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.karla(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Exercise Name",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    CheckboxListTile(
                      value: false,
                      onChanged: (val) {},
                      title: Text("Hey"),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: Colors.primaries.length,
                itemBuilder: ((context, index) {
                  final color = Colors.primaries[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15),
                    child: InkWell(
                      onTap: () {
                        ref.watch(colorProvider.state).state = color;
                      },
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: color,
                      ),
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                textColor: Colors.white,
                child: Text("Guardar"),
                color: Color.fromARGB(255, 54, 54, 54),
                onPressed: () {
                  _onsave();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
