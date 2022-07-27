import 'package:flutter/material.dart';

class ExerciseWidget extends StatefulWidget {
  String name;

  ExerciseWidget({required this.name});

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: (Container(
        width: 150,
        height: 150,
        color: Colors.black26,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.name),
            ],
          ),
        ),
      )),
    );
  }
}
