import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymapp/classes/ExerciseClass.dart';

final TimeGlobalProvider = Provider<int>((ref) {
  return 120;
});

final runingProvider = StateProvider<bool>((ref) => false);
final counterProvider = StateProvider((ref) => 0);
final DarkThemeProvider = StateProvider<bool>((ref) => true);
final homeindexProvider = StateProvider((ref) => 0);
final secondtickProvider = StateProvider((ref) => 120);
