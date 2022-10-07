import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymapp/classes/ExerciseClass.dart';

final TimeGlobalProvider = Provider<int>((ref) {
  return 120;
});

final gymBroProvider = StateProvider<String>((ref) {
  return "Matthew";
});

//Cronometro 1
final maingymBroProvider = StateProvider<String>((ref) => "");
final runingProvider = StateProvider<bool>((ref) => false);
final secondtickProvider = StateProvider((ref) => 120);
//Cronometro 2
final runingProvider2 = StateProvider<bool>((ref) => false);
final secondtickProvider2 = StateProvider((ref) => 120);
//Homepage
final homeindexProvider = StateProvider((ref) => 0);
final darkThemeProvider = StateProvider<bool>((ref) => true);
//AddExcercise
final colorProvider = StateProvider<Color>((ref) => Colors.amber);
