import 'package:flutter/material.dart';
import 'package:gymapp/screens/login.dart';
import 'package:gymapp/screens/main_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymapp/states/states.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/ExerciseClass.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    switcher();
    super.initState();
  }

  void switcher() async {
    final prefs = await SharedPreferences.getInstance();
    final log = prefs.getBool("Loged") ?? false;
    print(log);
    //SI no esta logeado entonces te manda a el login page
    if (log == false) {
      print("no esta logeado");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => login_page()));
    } else {
      //Si hay datos entonces
      String username = prefs.getString("username").toString();
      ref.read(maingymBroProvider.state).state = username;

      //se supone que entras
      //!AQUI CARGAMOS LOS DATOS Y LOS MANDO A RIVERPOD
      //cargamos los datos de esta madrinola
      final List<dynamic> jsonData =
          jsonDecode(prefs.getString('Exercises') ?? '[]');
      //ya aqui tenemos los datos para ser almacenados en donde quieras
      for (var Exe in jsonData) {
        Exercise x = Exercise.fromJson(Exe);
        ref.read(ExerciseProvider.notifier).addExercise(x);
      }

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Main_Page(Username: username)));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Icon(Icons.abc_outlined)),
    );
  }
}
