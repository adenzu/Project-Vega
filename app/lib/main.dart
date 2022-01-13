import 'package:app/database/message_type.dart';
import 'package:app/general/util.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _handleMessage(RemoteMessage message) {
    String dataType = message.data["type"];
    String dataValue = message.data["value"];

    switch (dataType) {
      case MessageType.requestRespond:
        break;
      case MessageType.requestReceive:
        redirectionTo(ScreenNames.pendingUsers)(context);
        break;
      default:
        return;
    }
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
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
