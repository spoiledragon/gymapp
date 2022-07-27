import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/states/states.dart';

class ExerciseList extends ConsumerStatefulWidget {
  const ExerciseList({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExerciseListState();
}

class _ExerciseListState extends ConsumerState<ExerciseList> {
  @override
  Widget build(BuildContext context) {
    final contador = ref.watch(counterProvider);
    return ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: contador,
        //!Creador de la lista en horizontal
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print(index);
            },
            child: (Text(" x ")),
          );
        });
  }
}
