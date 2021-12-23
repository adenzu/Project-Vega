import 'package:app/general/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'welcome/screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const WelcomeScreen(),

      /// screens.dart dosyasında Screens classında screenMapte
      /// olan sayfaları route'a ekleme satırı, yeni sayfaları
      /// screen.dart'a ekleyin
      routes: Screens.screenMap
          .map((key, value) => MapEntry(key, (context) => value)),
    );
  }
}
