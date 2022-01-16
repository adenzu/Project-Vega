import 'package:app/database/notification_type.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'welcome/screen.dart';
import 'general/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

/// TODO: delete 'a' class

class a extends StatelessWidget {
  String t;

  a({Key? key, required this.t}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(t),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // TODO:
  // void _handleMessage(RemoteMessage message) {
  //   String dataType = message.data["type"];
  //   String dataValue = message.data["value"];

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => a(t: "$dataType $dataValue"),
  //     ),
  //   );
  //   switch (dataType) {
  //     case NotificationType.requestRespond:
  //       break;
  //     case NotificationType.requestReceive:
  //       break;
  //     default:
  //       return;
  //   }
  // }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      // _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessage.listen((event) {});
    // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
  }

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
      /// screens.dart'a ekleyin
      routes: Screens.screensMap
          .map((key, value) => MapEntry(key, (context) => value)),
    );
  }
}
