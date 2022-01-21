import 'package:app/database/functions.dart';
import 'package:app/general/util.dart';
import 'package:app/route/screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../shared/slide_menu.dart';
import 'body.dart';
import 'package:app/database/notification_type.dart';
import 'package:app/database/request.dart';
import 'package:app/general/screens.dart';
import 'package:app/shuttle/screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';
import 'body.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isEmployee = false;
  @override
  void initState() {
    super.initState();

    print(0);
    checkEmployee().then((value) {
      print(1);
      print(value);
      if (value) {
        print(2);
        Location.instance.enableBackgroundMode();
        Location.instance.onLocationChanged.listen((LocationData loc) async {
          print(555);
          if (FirebaseAuth.instance.currentUser != null) {
            print(3);
            String userId = getUserId();
            DatabaseReference currShuttle = FirebaseDatabase.instance
                .reference()
                .child("employees/$userId/currentShuttle");
            DataSnapshot currShuttleDataSnap = await currShuttle.once();
            if (currShuttleDataSnap.exists) {
              print(4);
              String currShuttleId = currShuttleDataSnap.value;
              setShuttleLocation(currShuttleId, loc.longitude!, loc.altitude!);
            }
          }
        });
      }
    });
  }

  Future<bool> checkEmployee() async {
    isEmployee = await checkEmployeeExists(getUserId());
    return isEmployee;
  }

  void _handleMessage(RemoteMessage message) {
    String dataType = message.data["type"];
    String dataValue = message.data["value"];

    switch (dataType) {
      case NotificationType.connectionRequestReceive:
        Navigator.pushNamed(context, ScreenNames.pendingUsers);
        break;
      case NotificationType.connectionRequestRespond:
        switch (dataValue.parseRequest()) {
          case Request.accept:
            Navigator.pushNamed(context, ScreenNames.childProfiles);
            break;
          case Request.reject:
            break;
          default:
        }
        break;
      case NotificationType.employeeRequestReceive:
        String shuttleId = message.data["shuttleId"];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShuttleScreen(shuttleId: shuttleId),
          ),
        );
        break;
      case NotificationType.employeeRequestRespond:
        switch (dataValue.parseRequest()) {
          case Request.accept:
            String shuttleId = message.data["shuttleId"];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShuttleScreen(shuttleId: shuttleId),
              ),
            );
            break;
          case Request.reject:
            break;
          default:
        }
        break;
      case NotificationType.routeSubRequestReceive:
        String routeId = message.data["routeId"];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RouteScreen(routeID: routeId),
          ),
        );
        break;
      case NotificationType.routeSubRequestRespond:
        switch (dataValue.parseRequest()) {
          case Request.accept:
            Navigator.pushNamed(context, ScreenNames.myShuttle);
            break;
          case Request.reject:
            break;
          default:
        }
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

    FirebaseMessaging.onMessage.listen((event) {
      RemoteNotification? notification = event.notification;
      AndroidNotification? android = event.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setupInteractedMessage(),
      builder: (context, snapshot) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Vega",
          ),
          foregroundColor: Colors.blue,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: const Color(0xFFD8D8D8),
        drawer: SlideMenu(),
        body: const MainBody(),
      ),
    );
  }
}
