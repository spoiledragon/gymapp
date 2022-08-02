import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/Widgets/ExerciseWidget.dart';
import 'package:gymapp/classes/ExerciseClass.dart';
import 'package:gymapp/states/states.dart';

class ExerciseList extends ConsumerStatefulWidget {
  const ExerciseList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExerciseListState();
}

class _ExerciseListState extends ConsumerState<ExerciseList> {
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
          return GestureDetector(
            onTap: () {
              print(index);
            },
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExerciseWidget(
                  name: _ejercicios[index].name,
                  color: _ejercicios[index].color,
                )),
          );
        });
  }
}
