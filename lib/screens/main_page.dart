import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gymapp/screens/homePageScren.dart';
import 'package:gymapp/screens/trackPage.dart';

import "package:gymapp/states/states.dart";

class Main_Page extends ConsumerWidget {
  late String Username;
  Main_Page({required this.Username});
//@listas
  final ScreensPages = [
    HomePage(),
    trackPage(),
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    changeColor() {
      print(ref.read(DarkThemeProvider));
      ref.watch(DarkThemeProvider)
          ? ref.watch(DarkThemeProvider.state).state = false
          : ref.watch(DarkThemeProvider.state).state = true;
    }

    //providers
    int index = ref.read(homeindexProvider);
    void _onItemTapped(int index) {
      ref.watch(homeindexProvider.state).state = index;
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(Username)),
        actions: [
          IconButton(onPressed: changeColor, icon: Icon(Icons.dark_mode))
        ],
      ),
      body: IndexedStack(index: index, children: ScreensPages),

      //!Bottom Navigation

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse_outlined),
            label: 'Clock',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Tracking',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.pink,
          ),
        ],
        currentIndex: ref.read(homeindexProvider),
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
