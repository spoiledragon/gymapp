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
    if (name.isNotEmpty) {
      final finalcolor = ref.read(colorProvider.state);

      final retornado = Exercise(
          day: "Today",
          name: name,
          weight: int.parse(weightController.text),
          color: finalcolor.state,
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: TextField(
                        controller: nameController,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.karla(
                            color: Colors.white, fontSize: 15),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.abc_outlined),
                          hintText: "Name",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all()),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: TextField(
                          controller: weightController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(3),
                          ],
                          style: GoogleFonts.karla(
                              color: Colors.white, fontSize: 15),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.fitness_center),
                            suffix: Text("Lb"),
                            hintText: "Weight",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),

                    //CUPERTINO PICKER
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          "Group : ",
                          style: GoogleFonts.karla(),
                        )),
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
                                ref.watch(groupProvider.state).state =
                                    selectedItem;
                              },
                              children: List<Widget>.generate(
                                  _groupNames.length, (int index) {
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
