import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymapp/screens/splashScreen.dart';
import './states/states.dart';

// Creamos un "provider", el cual almacenará un valor (aquí "Hello world").
// El usar un provider nos permitirá simular/sobrescribir el valor expuesto.

void main() {
  runApp(
    // Para que los widgets puedan leer los providers, necesitamos envolver
    // toda la aplicación en un "ProviderScope".
    // Aquí es donde se almacenará el estado de nuestros providers.
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(darkThemeProvider);
    return MaterialApp(
      theme: isDarkTheme ? ThemeData.dark(
        
      ) : ThemeData.light(),
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}
