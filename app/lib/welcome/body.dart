import 'dart:async';
import 'package:app/main/screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/circular_button.dart';
import '../login/screen.dart';
import '../signup/screen.dart';

class WelcomeScreenBody extends StatefulWidget {
  const WelcomeScreenBody({Key? key}) : super(key: key);

  @override
  State<WelcomeScreenBody> createState() => _WelcomeScreenBodyState();
}

class _WelcomeScreenBodyState extends State<WelcomeScreenBody> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/deneysel4.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.65),
          CircularButton(
            buttonText: "LOGIN",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
          SizedBox(height: size.height * 0.04),
          CircularButton(
            buttonText: "SIGN-UP",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUp()));
            },
          ),
        ],
      ),
    );
  }

  void startTimer() {
    Timer(const Duration(seconds: 3), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    if (status) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()));
    }
  }


  // @override
  // Widget build(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   return Container(
  //     height: size.height,
  //     width: double.infinity,
  //     margin: const EdgeInsets.symmetric(vertical: 10),
  //     decoration: const BoxDecoration(
  //       image: DecorationImage(
  //         image: AssetImage("assets/images/deneysel4.png"),
  //         fit: BoxFit.cover,
  //       ),
  //     ),
  //     child: Column(
  //       children: [
  //         SizedBox(height: size.height * 0.65),
  //         CircularButton(
  //           buttonText: "LOGIN",
  //           press: () {
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) => const LoginScreen()));
  //           },
  //         ),
  //         SizedBox(height: size.height * 0.04),
  //         CircularButton(
  //           buttonText: "SIGN-UP",
  //           press: () {
  //             Navigator.push(context,
  //                 MaterialPageRoute(builder: (context) => const SignUp()));
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
