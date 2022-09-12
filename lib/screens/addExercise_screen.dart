import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
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

//PROVIDERS
final colorProvider = StateProvider<Color>((ref) => Colors.primaries.last);
final groupProvider = StateProvider<int>((ref) => 1);

class _AddExercise_classState extends ConsumerState<AddExercise_class> {
  //Controllers
  final nameController = TextEditingController();
  final weightController = TextEditingController();

  //vars
  String? error;
  final List<String> _groupNames = <String>[
    "Chest",
    "Leg",
    "Arm",
    "Shoulder",
    "Other"
  ];

  //Metodos
  _onsave() {
    final name = nameController.text.trim();
    //si no esta vacio lo quie se ha regresado
    if (name.isNotEmpty) {
      final finalcolor = ref.read(colorProvider.state);
      //creamso un objeto ejercicio que sera agregado a la lista
      final retornado = Exercise(
          day: "Today",
          name: name,
          weight: int.parse(weightController.text),
          group: _groupNames[ref.read(groupProvider)]);

      Navigator.of(context).pop(retornado);
    } else {}
  }

  //cupertino picker
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: Colors.white,
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
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

                  children: [
                    TextField(
                      controller: nameController,
                      textAlign: TextAlign.center,
                      style:
                          GoogleFonts.karla(color: Colors.white, fontSize: 15),
                      decoration: InputDecoration(

                        hintText: "Name",
                      ),
                    ),
                    TextField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(3),
                      ],
                      style:
                          GoogleFonts.karla(color: Colors.white, fontSize: 15),
                      decoration: InputDecoration(
                        hintText: "Weight",
                        border: InputBorder.none,
                      ),
                    ),

                    //CUPERTINO PICKER

                    CupertinoButton(
                      child: Center(
                        child: Text(
                          _groupNames[ref.watch(groupProvider)],
                          style: GoogleFonts.karla(color: Colors.white70),
                        ),
                      ),
                      onPressed: () => _showDialog(
                        CupertinoPicker(
                          magnification: 1.22,
                          squeeze: 1.2,
                          useMagnifier: true,
                          itemExtent: 32,
                          looping: true,

                          // This is called when selected item is changed.
                          onSelectedItemChanged: (int selectedItem) {
                            ref.watch(groupProvider.state).state = selectedItem;
                          },
                          children: List<Widget>.generate(_groupNames.length,
                              (int index) {
                            return Center(
                              child: Text(
                                _groupNames[index],
                                style: GoogleFonts.karla(),
                              ),
                            );
                          }),
                        ),
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
