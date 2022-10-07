import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';
import 'package:gymapp/classes/ExerciseClass.dart';

class ExerciseScreen extends StatefulWidget {
  ExerciseScreen({required this.ejercicio});
  final Exercise ejercicio;
  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  List<String> dias = [];
  Color? color;

  @override
  void initState() {
    //Convertimos el color de entero a color
    color = Color(widget.ejercicio.color);
    var ab = json.decode(widget.ejercicio.day);
    print(ab);
    for (String dia in ab) {
      dias.add(dia);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          Text(widget.ejercicio.weight.toString()),
          Text(widget.ejercicio.day),
          CircleAvatar(
            backgroundColor: color,
          )
        ],
      )),
    );
  }
}
