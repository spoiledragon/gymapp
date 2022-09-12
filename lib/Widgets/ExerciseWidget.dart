import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExerciseWidget extends StatefulWidget {
  String name;
  Color? color;
  String? group;

  ExerciseWidget({required this.name, this.group});

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.color,
        ),
        width: 150,
        height: 150,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.name,
                style: GoogleFonts.karla(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
