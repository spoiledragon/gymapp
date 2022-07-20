import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void loginbtn() {
    if ((userController.text == "spoiled") ||
        (passwordController.text == "digimon123")) {
      print("Entras papito");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => main_Page(Username: userController.text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // ignore: prefer_const_literals_to_create_immutables
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
                "Welcome Back",
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
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
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
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
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
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
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
