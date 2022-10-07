import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:gymapp/classes/ExerciseClass.dart';
import 'package:intl/intl.dart';
import 'package:gymapp/screens/addExercise_screen.dart';

import '../Widgets/Listview.dart';

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    //Listas
    List<Exercise> _ejercicios = ref.watch(ExerciseProvider);
    List<Exercise> _todayejercicios =
        ref.watch(ExerciseProvider.notifier).todayExercises();
    //valores
    var today = DateFormat('EEEE').format(DateTime.now());
    //Funciones

    //funciones

    Future<void> _addExercise() async {
      final result = await showDialog(
        context: context,
        builder: (_) => AddExercise_class(),
      );

      if (result != null) {
        ref.read(ExerciseProvider.notifier).addExercise(result);
        //se lo mandamos a nuestro notificador
      }
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _addExercise();
        },
        backgroundColor: Colors.orangeAccent,
      ),
      body: _todayejercicios.isEmpty
          ? Center(child: Text("No Hay ejercicios"))
          : Center(
              //! Sale el Nombre de usuario de Inicio
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Today is " + today,
                    style: GoogleFonts.bebasNeue(
                        fontSize: 30, color: Colors.white),
                  ),
                  Expanded(
                    child: ExerciseList(),
                  ),
                ],
              ),
            ),
    );
  }
}
