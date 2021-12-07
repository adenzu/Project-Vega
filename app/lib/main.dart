import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

import 'general/theme_model.dart';
import 'general/screens.dart';
import 'materials/themes.dart';
import 'general/util.dart';

Future<void> backgroundMessageHandler(RemoteMessage event) async {
  return;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
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
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then((event) {});

    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {
        print(event.notification!.title);
        print(event.notification!.body);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      redirectionTo(event.data["route"])(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeModel(),
      child: Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) => MaterialApp(
          home: Screens.main,
          theme: Themes.map[themeNotifier.themeId],
          routes: Screens.screenMap
              .map((key, value) => MapEntry(key, (_) => value)),
        ),
      ),
    );
  }
}
