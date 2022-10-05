import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymapp/states/states.dart';

class clockPage1 extends ConsumerStatefulWidget {
  const clockPage1({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _clockPage1State();
}

class _clockPage1State extends ConsumerState<clockPage1> {
  @override
  Timer? timer;

  Widget build(BuildContext context) {
    int TotalTimer = ref.read(TimeGlobalProvider);
    int ticks = ref.watch(secondtickProvider);
    bool isRunning = ref.watch(runingProvider);
    //FUNCIONES

    void pauseTimer() {
      ref.read(runingProvider.state).state = false;
      timer?.cancel();
    }

    void stopTimer() {
      print("cancelado");
      ref.read(runingProvider.state).state = false;
      ref.read(secondtickProvider.state).state = ref.read(TimeGlobalProvider);
      timer?.cancel();
    }

    void starttimer() {
      if (ref.read(runingProvider) == false) {
        ref.read(runingProvider.state).state = true;
        //timer
        timer = Timer.periodic(Duration(seconds: 1), (Timer) {
          //el no va a parar
          if (ref.read(secondtickProvider) > 0 && ref.read(runingProvider)) {
            ref.read(secondtickProvider.state).state--;
          }
        });
      } else {
        stopTimer();
      }
    }

    Widget buildTime() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(ref.read(maingymBroProvider)),
            Text(
              "$ticks",
              style: GoogleFonts.bebasNeue(fontSize: 60, color: Colors.white),
            ),
          ],
        );

    Widget buildTimer() => SizedBox(
          width: 150,
          height: 150,
          child: Stack(fit: StackFit.expand, children: [
            CircularProgressIndicator(
              strokeWidth: 12,
              value: ticks / ref.read(TimeGlobalProvider),
            ),
            Center(child: buildTime())
          ]),
        );

    Widget buildButtons() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: (() => {
                    pauseTimer(),
                  }),
              child: Text("Pause"),
            ),
            MaterialButton(
              onPressed: (() => {
                    stopTimer(),
                  }),
              child: Text("Cancel"),
            ),
          ],
        );

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //esta corriendo?
          isRunning
              //Si
              ? Center(
                  child: Column(
                    children: [
                      buildTimer(),
                      SizedBox(
                        height: 20,
                      ),
                      buildButtons(),
                    ],
                  ),
                )
              :
              //No
              Center(
                  child: MaterialButton(
                    onPressed: (() => starttimer()),
                    child: Text("Start"),
                  ),
                ),
        ],
      ),
    );
  }
}
