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
  void deleItem(String name) {
    ref.watch(ExerciseProvider.notifier).removeExercise(name);
  }

  Widget build(BuildContext context) {
    List<Exercise> _ejercicios = ref.watch(ExerciseProvider);
    List<Exercise> _todayejercicios =
        ref.watch(ExerciseProvider.notifier).todayExercises();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: _todayejercicios.length,
      itemBuilder: ((context, index) {
        final ejercicio = _todayejercicios[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: InkWell(
            onTap: () {
              gotoExercise(ejercicio);
            },
            onLongPress: () {
              //aqui deberia haber un minimodal pero pura verga papi
              deleItem(ejercicio.name);
            },
            child: ExerciseWidget(
              name: ejercicio.name,
              group: ejercicio.group,
              selectedColor: ejercicio.color,
            ),
          ),
        );
      }),
    );
  }
}
