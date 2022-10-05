import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymapp/states/states.dart';

class clockPage2 extends ConsumerStatefulWidget {
  const clockPage2({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _clockPage2State();
}

class _clockPage2State extends ConsumerState<clockPage2> {
  @override
  Timer? timer;

  Widget build(BuildContext context) {
    int TotalTimer = ref.read(TimeGlobalProvider);
    int ticks = ref.watch(secondtickProvider2);
    bool isRunning = ref.watch(runingProvider2);
    //FUNCIONES

    void pauseTimer() {
      ref.read(runingProvider2.state).state = false;
      timer?.cancel();
    }

    void stopTimer() {
      print("cancelado");
      ref.read(runingProvider2.state).state = false;
      ref.read(secondtickProvider2.state).state = ref.read(TimeGlobalProvider);
      timer?.cancel();
    }

    void starttimer() {
      if (ref.read(runingProvider2) == false) {
        ref.read(runingProvider2.state).state = true;
        //timer
        timer = Timer.periodic(Duration(seconds: 1), (Timer) {
          //el no va a parar
          if (ref.read(secondtickProvider2) > 0 && ref.read(runingProvider2)) {
            ref.read(secondtickProvider2.state).state--;
          }
        });
      } else {
        stopTimer();
      }
    }

    Widget buildTime() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(ref.read(gymBroProvider)),
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
