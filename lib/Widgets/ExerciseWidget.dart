import 'package:flutter/material.dart';

class ExerciseWidget extends StatefulWidget {
  String name;
  Color? color;

  ExerciseWidget({required this.name, required this.color});

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: widget.color,
        width: 150,
        height: 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.name),
            ],
          ),
        ),
      ),
    );
  }
}
