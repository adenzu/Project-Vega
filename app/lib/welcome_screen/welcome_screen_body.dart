import 'package:flutter/material.dart';
import '../components/circular_button.dart';
import '../login_screen/login_screen.dart';
import '../signup/signup.dart';

class WelcomeScreenBody extends StatelessWidget {
  const WelcomeScreenBody({Key? key}) : super(key: key);

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
}
