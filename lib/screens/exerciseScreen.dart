import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gymapp/classes/ExerciseClass.dart';

class ExerciseScreen extends StatefulWidget {
  ExerciseScreen({required this.ejercicio});
  final Exercise ejercicio;
  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text(widget.ejercicio.weight.toString())),
    );
  }
}
