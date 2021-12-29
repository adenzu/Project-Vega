import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// verilen shuttle id'yi kullanıcının servislerine ekler
///
/// Örnek:
/// ```
/// addShuttle('S504');
///
/// database
///   shuttleEmployees
///     thisUser
///       shuttles
///         S504: true
/// ```
Future<void> addShuttle(String shuttleId) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  _setEmployeeShuttle(userId, shuttleId, true);
}

/// verilen shuttle id'yi kullanıcının servislerinden siler
///
/// Örnek:
/// ```
/// addShuttle('S504');
///
/// database
///   shuttleEmployees
///     thisUser
///       shuttles
///         S504: null   // deleted
/// ```
Future<void> removeShuttle(String shuttleId) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  _setEmployeeShuttle(userId, shuttleId, null);
}

/// rotaya abone olur
Future<void> subRoute(String routeId) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  _setUserRoute(userId, routeId, true);
  _setRouteUser(routeId, userId, {'isOn': false, 'status': 0});
}

/// rotaya abonelikten çıkar
Future<void> unsubRoute(String routeId) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  _setUserRoute(userId, routeId, null);
  _setRouteUser(routeId, userId, null);
}

/// çocuğu rotaya abone eder
Future<void> childSubRoute(String childId, String routeId) async {
  _setUserRoute(childId, routeId, true);
  _setRouteUser(routeId, childId, {'isOn': false, 'status': 0});
}

/// çocuğu rotaya abonelikten çıkar
Future<void> childUnsubRoute(String childId, String routeId) async {
  _setUserRoute(childId, routeId, null);
  _setRouteUser(routeId, childId, null);
}

/// verilen id'yi kullanıcının bağlı (children) profillerine ekler
Future<void> addChild(String childId) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  _setUserChild(userId, childId, true);
}

/// verilen id'yi kullanıcının bağlı (children) profillerinden siler
Future<void> removeChild(String childId) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  _setUserChild(userId, childId, null);
}

Future<void> createChild(String childId, dynamic value) async {
  _setUser(childId, value);
}

Future<void> deleteChild(String childId) async {
  _setUser(childId, null);
}

/// child için unique id oluşturur
Future<String> generateChildId() async {
  DataSnapshot snap = await _getChildCounter().once();
  await _increaseChildCounter();
  return "C" + snap.value.toString();
}

/// shuttle için unique id oluşturur
Future<String> generateShuttleId() async {
  DataSnapshot snap = await _getShuttleCounter().once();
  await _increaseShuttleCounter();
  return "S" + snap.value.toString();
}

/// route için unique id oluşturur
Future<String> generateRouteId() async {
  DataSnapshot snap = await _getRouteCounter().once();
  await _increaseRouteCounter();
  return "R" + snap.value.toString();
}

/// userı bindirir
Future<void> userGetOn(String userId, String routeId) async {
  return _updateRouteUser(userId, routeId, {'isOn': true});
}

/// userı indirir
Future<void> userGetOff(String userId, String routeId) async {
  return _updateRouteUser(userId, routeId, {'isOn': false});
}

Future<void> addFCMToken() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  return _setUserFCMToken(userId, fcmToken!, true);
}

Future<void> removeFCMToken() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  return _setUserFCMToken(userId, fcmToken!, null);
}

/*
/// hiyerarşi:
///```
/// database
///   childCounter
///   routeCounter
///   shuttleCounter
///   shuttleEmployees
///     employeeId
///       shuttles
///         shuttleId1
///         shuttleId2
///         ...
///   users
///     userId
///       name
///       surname
///       parents
///         parentId1
///         parentId2
///         ...
///       children
///         childId1
///         childId2
///         ...
///       fcmTokens                 // needed for notification
///         token1
///         token2
///         ...
///       routes
///         routeId1
///         routeId2
///         ...
///   shuttles
///     shuttleId
///       routes
///         routeId1: false         // is the route current route
///         routeId2: true          // current route
///         routeId3: false
///         ...
///       employees
///         employeeId1
///         epmloyeeId2
///         ...
///   routes
///     routeId
///       passengers
///         passengerId1
///           isOn: true            // is on the shuttle currently
///           status: 1             // will passenger be there, 1 for yes
///         passengerId2
///           isOn: false
///           status: 0             // 0 for won't use
///         passengerId3
///           isOn: false
///           status: 2             // 2 for late
///         ...
///```
///
*/

/* -------YASAK ALAN BAŞLANGICI------- */

Future<void> _setUser(String userId, dynamic value) async {
  FirebaseDatabase.instance.reference().child("users/$userId").set(value);
}

Future<void> _setUserFCMToken(
    String userId, String token, dynamic value) async {
  FirebaseDatabase.instance
      .reference()
      .child("users/$userId/fcmTokens/$token")
      .set(value);
}

Future<void> _setEmployeeShuttle(
    String employeeId, String shuttleId, dynamic value) async {
  FirebaseDatabase.instance
      .reference()
      .child("shuttleEmployees/$employeeId/shuttles/$shuttleId")
      .set(value);
}

Future<void> _setRouteUser(String routeId, String userId, dynamic value) async {
  FirebaseDatabase.instance
      .reference()
      .child("routes/$routeId/passengers/$userId")
      .set(value);
}

Future<void> _updateRouteUser(
    String routeId, String userId, Map<String, dynamic> value) async {
  FirebaseDatabase.instance
      .reference()
      .child("routes/$routeId/passengers/$userId")
      .update(value);
}

Future<void> _setUserRoute(String userId, String routeId, dynamic value) async {
  FirebaseDatabase.instance
      .reference()
      .child("users/$userId/routes/$routeId")
      .set(value);
}

Future<void> _setUserChild(String userId, String childId, dynamic value) async {
  FirebaseDatabase.instance
      .reference()
      .child("users/$userId/children/$childId")
      .set(value);
}

Future<void> _increaseChildCounter() async {
  FirebaseDatabase.instance
      .reference()
      .update({"childCounter": ServerValue.increment(1)});
}

DatabaseReference _getChildCounter() {
  return FirebaseDatabase.instance.reference().child("childCounter");
}

Future<void> _increaseShuttleCounter() async {
  FirebaseDatabase.instance
      .reference()
      .update({"shuttleCounter": ServerValue.increment(1)});
}

DatabaseReference _getShuttleCounter() {
  return FirebaseDatabase.instance.reference().child("shuttleCounter");
}

Future<void> _increaseRouteCounter() async {
  FirebaseDatabase.instance
      .reference()
      .update({"routeCounter": ServerValue.increment(1)});
}

DatabaseReference _getRouteCounter() {
  return FirebaseDatabase.instance.reference().child("routeCounter");
}

/* -------YASAK ALAN SONU------- */
