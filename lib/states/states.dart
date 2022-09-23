import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymapp/classes/ExerciseClass.dart';

final counterProvider = StateProvider((ref) => 0);
final DarkThemeProvider = StateProvider<bool>((ref) => true);
final homeindexProvider = StateProvider((ref) => 0);
final secondsTimeProvider = StateProvider((ref) => 60);
final secondtickProvider = StateProvider((ref) => 60);
