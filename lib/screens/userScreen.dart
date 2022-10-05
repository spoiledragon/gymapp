import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gymapp/classes/localNoti/local_noti.dart';

class userPage extends StatefulWidget {
  const userPage({Key? key}) : super(key: key);

  @override
  State<userPage> createState() => _userPageState();
}

class _userPageState extends State<userPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            print("noti");
            final NotificationsApp noti = new NotificationsApp();
            noti.showNotification();
          },
        ),
      ),
    );
  }
}
