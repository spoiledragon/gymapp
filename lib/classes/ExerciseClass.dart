// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
// El estado de nuestro StateNotifier debe ser inmutable.
// También podríamos usar paquetes como Freezed para ayudar con la implementación.

class Exercise {
  const Exercise(
      {required this.name,
      required this.day,
      required this.weight,
      required this.group});

  // Todas las propiedades deben ser `final` en nuestra clase.
  final String name;
  final String day;
  final int weight;

  final String group;

//serializacion a json
  Map toJson() => {
        'name': name,
        'day': day,
        'weight': weight,
        'group': group,
      };

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        name: json["name"],
        day: json["day"],
        weight: json["weight"],
        group: json["group"],
      );
  // Como `Todo` es inmutable, implementamos un método que permite clonar el
  // `Todo` con un contenido ligeramente diferente.
  Exercise copyWith(
      {String? name, String? day, int? weight, Color? color, String? group}) {
    return Exercise(
      name: name ?? this.name,
      day: day ?? this.day,
      weight: weight ?? this.weight,
      group: group ?? this.group,
    );
  }
}

// La clase StateNotifier que se pasará a nuestro StateNotifierProvider.
// Esta clase no debe exponer el estado fuera de su propiedad "estado", lo que significa
// ¡sin getters/propiedades públicas!
// Los métodos públicos en esta clase serán los que permitirán
// que la interfaz de usuario modifique el estado.
class ExerciseNotifier extends StateNotifier<List<Exercise>> {
  // Inicializamos la lista de `todos` como una lista vacía

  ExerciseNotifier() : super([]);
  //ExerciseNotifier() : super([]);
  // Permitamos que la interfaz de usuario agregue todos.
  void addExercise(Exercise ejercicio) {
    // Ya que nuestro estado es inmutable, no podemos hacer `state.add(todo)`.
    // En su lugar, debemos crear una nueva lista de todos que contenga la anterior
    // elementos y el nuevo.
    // ¡Usar el spread operator de Dart aquí es útil!
    state = [...state, ejercicio];
    // No es necesario llamar a "notifyListeners" o algo similar. Llamando a "state ="
    // reconstruirá automáticamente la interfaz de usuario cuando sea necesario.

    //!AQUI PONDREMOS QUE SE GUARDEN LAS COSAS

    savebitches();
  }

  // Permitamos eliminar `todos`
  void removeExercise(String nombre) {
    // Nuevamente, nuestro estado es inmutable. Así que estamos haciendo
    // una nueva lista en lugar de cambiar la lista existente.
    state = [
      for (final todo in state)
        if (todo.name != nombre) todo,
    ];
    savebitches();
  }

  savebitches() async {
    print(state);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('Exercises', jsonEncode(state));
  }
}

// Finalmente, estamos usando StateNotifierProvider para permitir que la
// interfaz de usuario interactúe con nuestra clase TodosNotifier.
final ExerciseProvider =
    StateNotifierProvider<ExerciseNotifier, List<Exercise>>((ref) {
  return ExerciseNotifier();
});
