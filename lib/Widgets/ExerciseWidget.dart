import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseWidget extends StatefulWidget {
  String name;
  int selectedColor;
  String? group;

  ExerciseWidget(
      {required this.name, required this.group, required this.selectedColor});

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.black26,
      ),
      height: 50,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Circulo(),
          SizedBox(
            width: 20,
          ),
          Text(
            widget.name,
            style: GoogleFonts.karla(fontSize: 20),
          ),
        ],
      ),
    );
  }

  Widget Circulo() {
    return Container(
      width: 30,
      height: 30,
      decoration: ShapeDecoration(
        shape: CircleBorder(
          side: BorderSide(width: 2, color: Color(widget.selectedColor)),
        ),
      ),
    );
  }
}
