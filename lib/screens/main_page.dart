import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymapp/Widgets/Listview.dart';
import 'package:gymapp/classes/ExerciseClass.dart';
import 'package:gymapp/screens/addExercise_screen.dart';
import 'package:intl/intl.dart';
import "package:gymapp/states/states.dart";

class Main_Page extends ConsumerWidget {
  late String Username;
  Main_Page({required this.Username});
//@listas
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //providers

    List<Exercise> _ejercicios = ref.watch(ExerciseProvider);

    //valores
    var today = DateFormat('EEEE').format(DateTime.now());
    //Funciones
    changeColor() {
      print(ref.read(DarkThemeProvider));
      ref.watch(DarkThemeProvider)
          ? ref.watch(DarkThemeProvider.state).state = false
          : ref.watch(DarkThemeProvider.state).state = true;
    }

    //funciones

    Future<void> _addExercise() async {
      final result = await showDialog(
        context: context,
        builder: (_) => AddExercise_class(),
      );

      if (result != null) {
        ref.watch(ExerciseProvider.notifier).addExercise(result);
        //se lo mandamos a nuestro notificador
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(Username)),
        actions: [
          IconButton(onPressed: changeColor, icon: Icon(Icons.dark_mode))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addExercise();
        },
        backgroundColor: Colors.orangeAccent,
      ),
      body: _ejercicios.isEmpty
          ? Center(child: Text("No Hay ejercicios"))
          : Center(
              //! Sale el Nombre de usuario de Inicio

              child: Column(
                children: <Widget>[
                  Text(
                    "Today is " + today,
                    style: GoogleFonts.bebasNeue(
                        fontSize: 30, color: Colors.white),
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
          backgroundColor: Colors.white,
          icon: Icon(
            Icons.sports_gymnastics,
            color: Colors.orangeAccent,
          ),
        ),
        BottomNavigationBarItem(
          label: "Hola2",
          icon: Icon(
            Icons.sports_gymnastics,
            color: Colors.orangeAccent,
          ),
        ),
        BottomNavigationBarItem(
          label: "Hola3",
          icon: Icon(
            Icons.sports_gymnastics,
            color: Colors.orangeAccent,
          ),
        ),
      ]),
    );
  }
}
