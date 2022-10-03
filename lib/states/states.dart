import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymapp/classes/ExerciseClass.dart';

final TimeGlobalProvider = Provider<int>((ref) {
  return 120;
});

final gymBroProvider = StateProvider<String>((ref) {
  return "Matthew";
});
final maingymBroProvider = StateProvider<String>((ref) => "");

final runingProvider = StateProvider<bool>((ref) => false);

final runingProvider2 = StateProvider<bool>((ref) => false);
final counterProvider = StateProvider((ref) => 0);
final DarkThemeProvider = StateProvider<bool>((ref) => true);
final homeindexProvider = StateProvider((ref) => 0);

final secondtickProvider = StateProvider((ref) => 120);

final secondtickProvider2 = StateProvider((ref) => 120);
