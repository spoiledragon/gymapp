import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/Widgets/ExerciseWidget.dart';
import 'package:gymapp/classes/ExerciseClass.dart';

import '../screens/exerciseScreen.dart';

class ExerciseList extends ConsumerStatefulWidget {
  const ExerciseList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExerciseListState();
}

class _ExerciseListState extends ConsumerState<ExerciseList> {
  Future<void> gotoExercise(Exercise exe) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ExerciseScreen(ejercicio: exe),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Exercise> _ejercicios = ref.watch(ExerciseProvider);
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: _ejercicios.length,
        //!Creador de la lista en horizontal
        itemBuilder: (BuildContext context, int index) {
          final ejercicio = _ejercicios[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: InkWell(
              child: ExerciseWidget(
                name: ejercicio.name,
                color: ejercicio.color,
                icon: ejercicio.icono,
              ),
              onTap: () {
                gotoExercise(ejercicio);
              },
            ),
          );
        });
  }
}
