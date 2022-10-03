import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymapp/states/states.dart';

class clockPage extends ConsumerStatefulWidget {
  const clockPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _clockPageState();
}

class _clockPageState extends ConsumerState<clockPage> {
  @override
  Widget build(BuildContext context) {
    int TotalTimer = ref.read(TimeGlobalProvider);
    int ticks = ref.watch(secondtickProvider);
    Timer? timer;
    bool isRunning = ref.watch(runingProvider);

    //FUNCIONES

    void pauseTimer() {
      print("Pausado");
      ref.read(runingProvider.state).state = false;
      print(isRunning);
      timer?.cancel();
    }

    void stopTimer() {
      print("cancelado");
      ref.read(runingProvider.state).state = false;
      ref.read(secondtickProvider.state).state = ref.read(TimeGlobalProvider);
      print(isRunning);
      timer?.cancel();
    }

    void starttimer() {
      ref.read(runingProvider.state).state = true;
      //comienza el cronometro
      timer = Timer.periodic(Duration(seconds: 1), (Timer) {
        //el no va a parar
        if (ticks > 0 && ref.read(runingProvider) == true) {
          ticks = ref.watch(secondtickProvider.state).state--;
          print(ticks);
        } else {
          stopTimer();
        }
      });
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                                stopTimer(),
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
        ),
      ),
    );
  }
}
