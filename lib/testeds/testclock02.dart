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
  Widget build(BuildContext context) {
    int TotalTimer = ref.read(TimeGlobalProvider);
    int ticks = ref.watch(secondtickProvider2);
    Timer? timer;
    bool isRunning = ref.watch(runingProvider2);

    //FUNCIONES

    void pauseTimer() {
      print("Pausado");
      ref.read(runingProvider2.state).state = false;
      timer?.cancel();
    }

    void stopTimer() {
      print("cancelado");
      ref.read(runingProvider2.state).state = false;
      ref.read(secondtickProvider2.state).state = ref.read(TimeGlobalProvider);
      print(isRunning);
      timer?.cancel();
    }

    void starttimer() {
      ref.read(runingProvider2.state).state = true;
      //comienza el cronometro
      timer = Timer.periodic(Duration(seconds: 1), (Timer) {
        //el no va a parar
        if (ticks > 1 && ref.read(runingProvider2) == true) {
          ticks = ref.watch(secondtickProvider2.state).state--;
          print(ticks);
        } else {
          pauseTimer();
        }
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(ref.read(gymBroProvider)),
        Text(
          "$ticks",
          style: GoogleFonts.bebasNeue(fontSize: 60, color: Colors.white),
        ),
        isRunning
            ? Center(
                child: Row(
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
                ),
              )
            : MaterialButton(
                onPressed: (() => starttimer()),
                child: Text("Start"),
              ),
      ],
    );
  }
}
