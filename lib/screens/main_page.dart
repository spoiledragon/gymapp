import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymapp/Widgets/ExerciseWidget.dart';
import 'package:gymapp/Widgets/Listview.dart';
import 'package:gymapp/classes/ExerciseClass.dart';
import 'package:intl/intl.dart';
import "package:gymapp/states/states.dart";

class Main_Page extends ConsumerWidget {
  late String Username;
  Main_Page({required this.Username});
//@listas
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //providers

    StateController<int> counter = ref.watch(counterProvider.notifier);

    //valores
    var _exercies = [
      Exercise("tis", 200, "today"),
      Exercise("tis2", 2002, "today2"),
    ];
    var today = DateFormat('EEEE').format(DateTime.now());
    //Funciones
    changeColor() {
      print(ref.read(DarkThemeProvider));
      ref.watch(DarkThemeProvider)
          ? ref.watch(DarkThemeProvider.state).state = false
          : ref.watch(DarkThemeProvider.state).state = true;
    }

    pressscaffold() {
      var exe = Exercise("ADDED", 20000, "IDK");
      _exercies.add(exe);
      counter.state++;
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(Username)),
        actions: [
          IconButton(onPressed: changeColor, icon: Icon(Icons.dark_mode))
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        pressscaffold();
      }),
      body: Center(
        //! Sale el Nombre de usuario de Inicio

        child: Column(
          children: <Widget>[
            Text(
              "Today is " + today,
              style: GoogleFonts.bebasNeue(fontSize: 30, color: Colors.white),
            ),
            SizedBox(
              height: 150.0,
              child: Row(
                children: [
                  Expanded(
                    child: ExerciseList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      //!Bottom Navigation

      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          label: "Hola1",
          icon: Icon(Icons.sports_gymnastics),
        ),
        BottomNavigationBarItem(
          label: "Hola2",
          icon: Icon(Icons.sports_gymnastics),
        ),
        BottomNavigationBarItem(
          label: "Hola3",
          icon: Icon(Icons.sports_gymnastics),
        ),
      ]),
    );
  }
}
