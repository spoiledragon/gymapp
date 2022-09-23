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

final runingProvider = StateProvider<bool>((ref) => false);

class _clockPageState extends ConsumerState<clockPage> {
  @override
  Widget build(BuildContext context) {
    //Providers
    int ticks = ref.watch(secondtickProvider);
    bool isRunning = ref.watch(runingProvider);
//Vars
    Timer? timer;

    //FUNCIONES

    void stopTimer() {
      print("cancelado");
      timer?.cancel();
      isRunning = false;
      print(isRunning);
    }

    void starttimer() async {
      ref.read(runingProvider.state).state = true;
      if (ticks > 0 && !isRunning) {
        timer = Timer.periodic(Duration(seconds: 1), (Timer) {
          ticks = ref.watch(secondtickProvider.state).state--;
          print(ticks);
        });
      } else {
        stopTimer();
      }
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
                          onPressed: (() => {}),
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
