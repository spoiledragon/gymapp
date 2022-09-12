// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymapp/screens/main_page.dart';

class login_page extends StatefulWidget {
  const login_page({Key? key}) : super(key: key);

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    loadKeys();
    super.initState();
  }

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loadKeys() async {
    final userKeys = await SharedPreferences.getInstance();
    setState(() {
      userController.text = (userKeys.getString('username') ?? "");
      passwordController.text = (userKeys.getString('password') ?? "");
    });
  }

  Future<void> loginbtn() async {
    if ((userController.text == "spoiled") &&
        (passwordController.text == "digimon123")) {
      final _userKeys = await SharedPreferences.getInstance();
      setState(() {
        print("se ha guardado" + userController.text);
        _userKeys.setString('username', userController.text);
        _userKeys.setString('password', passwordController.text);
      });
      print("Entras papito");
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Main_Page(Username: userController.text)));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("User or Password ")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Icon(
                Icons.sports_gymnastics,
                size: 40,
              ),
              // ignore: prefer_const_constructors
              Text(
                "Hello Again!",
                style: GoogleFonts.bebasNeue(fontSize: 34),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Welcome Back ${userController.text}",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              //AQUI VAN LAS MAMADAS
              //username textfield
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: userController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Username",
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              //password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                      ),
                      obscureText: true,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //signing button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  onTap: () => loginbtn(),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Log In",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member?  ",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "Register Now",
                    style: TextStyle(
                        color: Colors.lightBlue, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
