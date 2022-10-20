// ignore_for_file: non_constant_identifier_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymapp/classes/ExerciseClass.dart';
import 'package:day_picker/day_picker.dart';

import 'package:gymapp/states/states.dart';

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
      "Wednesday",
    ),
    DayInWeek(
      "Thursday",
    ),
    DayInWeek(
      "Friday",
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
        group: _groupNames[ref.read(groupProvider)],
        color: ref.read(colorProvider).value,
      );

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

  Widget RepsPicker() {
    return CupertinoPicker(
      magnification: 1.22,
      squeeze: 1.2,
      useMagnifier: true,
      itemExtent: 32,
      looping: true,
      // This is called when selected item is changed.
      onSelectedItemChanged: (int selectedItem) {
        ref.read(repsProvider.state).state = selectedItem;
      },
      children: List<Widget>.generate(30, (int index) {
        return Center(
          child: Text(
            index.toString(),
            style: GoogleFonts.karla(),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reps = ref.watch(repsProvider);
    int sets = ref.watch(setsProvider);
    final Color selectedColor = ref.watch(colorProvider);

    return AlertDialog(
      backgroundColor: Colors.black,
      contentPadding: EdgeInsets.zero,
      insetPadding: EdgeInsets.zero,
      content: Column(
        //mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Colores(),
          //*Colorines
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(color: selectedColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Campos(),
                  //! CUPERTINO PICKER
                  Chips(),
                  Botoneria(),
                  daySelect(),
                ],
              ),
            ),
          ),

          //!Campos a Rellenar
          //!! Dias de la Semana
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
          ),
        ],
      ),
    );
  }

//!Botones
  Widget Botoneria() {
    return CupertinoButton(
      child: Center(
        child: Text(
          ref.read(repsProvider).toString(),
          style: GoogleFonts.karla(color: Colors.white70),
        ),
      ),
      onPressed: () => _showDialog(RepsPicker()),
    );
  }

  Widget Chips() {
    return SizedBox(
      width: 300,
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8),
        itemCount: _groupNames.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () => {}, child: Chip(label: Text(_groupNames[index])));
        },
        separatorBuilder: (BuildContext context, int index) =>
            const VerticalDivider(),
      ),
    );
  }

//!Campos
  Widget Campos() {
    return Column(
      children: [
        //*Nombre
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextField(
                textAlign: TextAlign.center,
                controller: nameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Name",
                ),
              ),
            ),
          ),
        ),
        //*Peso
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                ],
                style: GoogleFonts.karla(color: Colors.white, fontSize: 15),
                decoration: InputDecoration(
                  hintText: "Weight",
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        //*Reps

        //*Mancuerna, Polea o Barra
      ],
    );
  }

  //!Dias de la semana

  Widget daySelect() {
    return SelectWeekDays(
        backgroundColor: Colors.black26,
        daysFillColor: Colors.orangeAccent,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        days: _days,
        onSelect: (values) {
          print(values);
        });
  }

  Widget Colores() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      child: Expanded(
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: Colors.accents.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: InkWell(
                onTap: () {
                  ref.read(colorProvider.state).state = Colors.primaries[index];
                },
                child: CircleAvatar(
                  radius: 1,
                  backgroundColor: Colors.accents[index],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
