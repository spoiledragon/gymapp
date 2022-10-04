import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymapp/classes/ExerciseClass.dart';
import 'package:day_picker/day_picker.dart';
import 'package:day_picker/model/day_in_week.dart';

class AddExercise_class extends ConsumerStatefulWidget {
  const AddExercise_class({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddExercise_classState();
}

//PROVIDERS
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
    "Back",
    "Other"
  ];
  //Lista de dias
  List<DayInWeek> _days = [
    DayInWeek(
      "Monday",
    ),
    DayInWeek(
      "Tuesday",
    ),
    DayInWeek(
      "Wednesday ",
    ),
    DayInWeek(
      "Thursday ",
    ),
    DayInWeek(
      "Friday ",
    ),
    DayInWeek(
      "Saturday",
    ),
    DayInWeek(
      "Sunday",
    ),
  ];
  List<String> DiasString = [];

  //Metodos
  _onsave() {
    final name = nameController.text.trim();
    //si no esta vacio lo quie se ha regresado
    if (name.isNotEmpty) {
      //creamso un objeto ejercicio que sera agregado a la lista
      for (DayInWeek dia in _days) {
        if (dia.isSelected) {
          String temp = '"' + dia.dayName + '"';
          DiasString.add(temp);
        }
      }

      final retornado = Exercise(
          day: DiasString.toString(),
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
                color: Colors.black12,
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
                    //Dias de la Semana
                    SelectWeekDays(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      days: _days,
                      onSelect: (values) {
                        print(values);
                      },
                    ),
                  ],
                ),
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
