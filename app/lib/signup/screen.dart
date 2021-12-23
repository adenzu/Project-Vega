import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../welcome/screen.dart';
import '../service/auth.dart';

import 'mybutton.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  bool _visibilityOnOff1 = true;
  bool _visibilityOnOff2 = true;

  var _password = TextEditingController();
  var _rePassw = TextEditingController();
  var name = TextEditingController();
  var surname = TextEditingController();
  var _email = TextEditingController();

  String email = '';
  String _psswd = '';
  String _name = '';
  String _surname = '';
  String _repsswd = '';

  final TextEditingController myController = TextEditingController();
  AuthService _authService = AuthService();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    var value;
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/deney1.png"),
                fit: BoxFit.cover)), // child: Image.asset(
        //   'assets/images/background1.jpg',
        //   width: 400,
        //   height: 100,
        // ),
      ),
      ListView(children: <Widget>[
        const SizedBox(
          height: 120,
        ),
        Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(
                left: 40,
                top: 30,
                right: 30,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              height: 60,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3))
                  ]),
              child: TextField(
                controller: name,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  setState(() {
                    _name = text;
                  });
                },
                decoration: const InputDecoration(
                    hintText: 'Name',
                    border: InputBorder.none,
                    icon: Icon(Icons.person)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 30,
                right: 30,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              height: 60,
              width: 140,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3))
                  ]),
              child: TextField(
                controller: surname,
                keyboardType: TextInputType.text,
                onChanged: (text) {
                  setState(() {
                    _surname = text;
                  });
                },
                decoration: const InputDecoration(
                    hintText: 'Surname',
                    border: InputBorder.none,
                    icon: Icon(Icons.person)),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 40,
            top: 30,
            right: 30,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          height: 60,
          width: 340,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ]),
          child: TextField(
            controller: _email,
            keyboardType: TextInputType.text,
            onChanged: (text) {
              setState(() {
                email = text;
              });
            },
            decoration: const InputDecoration(
                hintText: 'E-mail address',
                border: InputBorder.none,
                icon: Icon(Icons.mail)),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 40,
            top: 30,
            right: 30,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          height: 60,
          width: 340,
          decoration: BoxDecoration(
              color: Colors.white, //!!!!!!!!!!!!!!!!!!!!!!!!!!!
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ]),
          child: TextFormField(
            controller: _password,
            keyboardType: TextInputType.text,
            onChanged: (text) {
              setState(() {
                _psswd = text;
              });
            },
            obscureText: _visibilityOnOff1,
            //This will obscure text dynamically
            decoration: InputDecoration(
              hintText: 'Enter your password',
              icon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _visibilityOnOff1 ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _visibilityOnOff1 = !_visibilityOnOff1;
                  });
                },
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 40,
            top: 30,
            right: 30,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          height: 60,
          width: 340,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3))
              ]),
          child: TextFormField(
            controller: _rePassw,
            keyboardType: TextInputType.text,
            onChanged: (text) {
              setState(() {
                _repsswd = text;
              });
            },
            obscureText: _visibilityOnOff2,
            decoration: InputDecoration(
              hintText: 're-Enter your password',
              icon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _visibilityOnOff2 ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    _visibilityOnOff2 = !_visibilityOnOff2;
                  });
                },
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 50, 0, 0),
          child: ButtonTheme(
            child: mybutton(
              press: () async {
                try {
                  if (_psswd == _repsswd && _name != "" && _surname != "") {
                    await _authService.SignUp(_name, _surname, email, _psswd)
                        .then((_) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()),
                      );
                    });
                  } else {
                    if (_psswd != _repsswd) {
                      Fluttertoast.showToast(
                        msg: 'Please make sure your passwords match.',
                        gravity: ToastGravity.TOP,
                      );
                    } else if (_name == "") {
                      Fluttertoast.showToast(
                        msg: 'Name must not be empty.',
                        gravity: ToastGravity.TOP,
                      );
                    } else if (_surname == "") {
                      Fluttertoast.showToast(
                        gravity: ToastGravity.TOP,
                        textColor: Colors.red,
                        msg: 'Surname must not be empty.',
                      );
                    }
                  }
                } on FirebaseAuthException catch (e) {
                  Fluttertoast.showToast(
                      msg: e.message.toString(),
                      gravity: ToastGravity.CENTER,
                      textColor: Colors.red);
                }
              },
              text: 'Sign Up',
            ),
            minWidth: 350.0,
          ),
        ),
      ])
    ]));
  }
}
