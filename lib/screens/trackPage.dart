import 'package:flutter/material.dart';

import 'package:gymapp/testeds/testclock01.dart';
import 'package:gymapp/testeds/testclock02.dart';

class trackPage extends StatefulWidget {
  const trackPage({Key? key}) : super(key: key);

  @override
  State<trackPage> createState() => _trackPageState();
}

class _trackPageState extends State<trackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           clockPage1(),
           Divider(),
           clockPage2(),
          ],
        ),
      ),
    );
  }
}
