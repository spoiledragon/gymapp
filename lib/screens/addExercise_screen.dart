import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymapp/classes/ExerciseClass.dart';

class AddExercise_class extends ConsumerStatefulWidget {
  const AddExercise_class({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddExercise_classState();
}

final colorProvider = StateProvider<Color>((ref) => Colors.primaries.last);

class _AddExercise_classState extends ConsumerState<AddExercise_class> {
  //Controllers
  final nameController = TextEditingController();
  //vars
  String? error;
  //Metodos
  _onsave() {
    final name = nameController.text.trim();
    if (name.isNotEmpty) {}
    final finalcolor = ref.read(colorProvider.state);
    final retornado = Exercise(
        day: "Today", name: name, weight: 999, color: finalcolor.state);
    Navigator.of(context).pop(retornado);
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
              child: Container(
                color: ref.read(colorProvider),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.boy_rounded,
                      size: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: nameController,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.karla(),
                        decoration: InputDecoration(
                            hintText: "Exercise Name",
                            border: InputBorder.none),
                      ),
                    ),
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
                color: Colors.teal[50],
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