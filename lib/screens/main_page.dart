// ignore_for_file: equal_elements_in_set

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:riverpod/riverpod.dart';
import '../states/states.dart';

class main_Page extends ConsumerWidget {
  String Username;
  main_Page({required this.Username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var date = DateTime.now();
    var todayDate = DateFormat('EEEE').format(date);
    var Days = {
      "Monday",
      "Thursday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    };

    var Exercises = [
      "Chest",
      "Back",
      "Leg",
      "pilin",
      "esto",
      "L2",
      "Chest",
      "Back",
      "Leg",
      "pilin",
      "esto",
      "L2",
    ];
    return Scaffold(
      appBar: AppBar(title: Center(child: Text(Username))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(ref.watch(DarkThemeProvider));
          ref.watch(DarkThemeProvider)
              ? ref.watch(DarkThemeProvider.state).state = false
              : ref.watch(DarkThemeProvider.state).state = true;
          print(ref.watch(DarkThemeProvider));
        },
      ),
      body: Center(
        //! Sale el Nombre de usuario de Inicio

        child: Column(
          children: <Widget>[
            Text(
              "Today is $todayDate",
              style: GoogleFonts.bebasNeue(fontSize: 30, color: Colors.white),
            ),
            SizedBox(
              height: 150.0,
              child: Row(
                children: [
                  Text("+"),
                  Expanded(
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: Exercises.length,
                      //!Creador de la lista en horizontal
                      itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          Exercises[index].toString(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      //!Bottom Navigation

      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          label: "Hola1",
          icon: Icon(Icons.sports_gymnastics),
        ),
        BottomNavigationBarItem(
          label: "Hola2",
          icon: Icon(Icons.sports_gymnastics),
        ),
        BottomNavigationBarItem(
          label: "Hola3",
          icon: Icon(Icons.sports_gymnastics),
        ),
      ]),
    );
  }
}
