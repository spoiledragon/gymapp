import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymapp/states/states.dart';

class clockPage extends ConsumerStatefulWidget {
  const clockPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _clockPageState();
}

class _clockPageState extends ConsumerState<clockPage> {
  @override
  Widget build(BuildContext context) {
    int seconds = ref.watch(secondsTimeProvider);

    //Timer? timer;

    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          buildTimer(seconds),
          buildButtons(),
        ]),
      ),
    );
  }

  Widget buildButtons() {
    return MaterialButton(
      onPressed: (() => starttimer()),
      child: Text("Start"),
    );
  }

  Widget buildTimer(seconds) {
    return Text("$seconds");
  }

  starttimer() async {
    Timer(Duration(seconds: ref.watch(secondsTimeProvider)), () {
      print('Yeah, this line is printed after 3 seconds');
    });
  }
}
