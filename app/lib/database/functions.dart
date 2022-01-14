import 'package:app/database/request.dart';
import 'package:app/database/user_use_route.dart';
import 'package:app/shuttle_creation/shuttle_info_class.dart';
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
///   employees
///     thisUser
///       shuttles
///         S504: true
/// ```
Future<void> createShuttle() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String shuttleId = await generateShuttleId();
  _setShuttle(shuttleId, true);
  _setEmployeeShuttle(userId, shuttleId, true);
}


/// verilen shuttle id'yi kullanıcının servislerinden siler
///
/// Örnek:
/// ```
/// addShuttle('S504');
///
/// database
///   employees
///     thisUser
///       shuttles
///         S504: null   // deleted
/// ```
Future<void> removeShuttle(String shuttleId) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  _setEmployeeShuttle(userId, shuttleId, null);
}

/// rotaya abone olur
@Deprecated(
    "Bu fonksiyon görevliye sormadan kullanıcıyı rotaya ekler. `requestRouteSub` kullan")
Future<void> subRoute(String routeId) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  _setUserRoute(userId, routeId, true);
  _setRouteUser(routeId, userId, {'isOn': false, 'status': 0});
}

/// çocuğu rotaya abone eder
@Deprecated(
    "Bu fonksiyon görevliye sormadan çocuğu rotaya ekler. `requestChildRouteSub` kullan")
Future<void> childSubRoute(String childId, String routeId) async {
  _setUserRoute(childId, routeId, true);
  _setRouteUser(routeId, childId, {'isOn': false, 'status': 0});
}

/// rotaya abone olma isteği yollar
Future<void> requestRouteSub(String routeId) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  _setSentRoute(userId, routeId, Request.pending);
}

/// rotaya abone olma isteği yollar
Future<void> requestChildRouteSub(String childId, String routeId) async {
  _setSentRoute(childId, routeId, Request.pending);
}

/// rotaya abonelikten çıkar
Future<void> unsubRoute(String routeId) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  _setUserRoute(userId, routeId, null);
  _setRouteUser(routeId, userId, null);
}

/// çocuğu rotaya abonelikten çıkar
Future<void> childUnsubRoute(String childId, String routeId) async {
  _setUserRoute(childId, routeId, null);
  _setRouteUser(routeId, childId, null);
}

/// `userId` id'li kullanıcıya onu "çocuk" profili olarak ekleme isteği yollar
Future<void> requestConnection(String userId) async {
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  _setSentUser(currentUserId, userId, Request.pending);
}

Future<void> cancelConnectionRequest(String userId) async {
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  _setSentUser(currentUserId, userId, Request.canceled);
}

Future<void> respondToConnectionRequest(String userId, Request req) async {
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  _setUserPending(currentUserId, userId, req);
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

/// çocuğu database'e verilen değerlere ekler
Future<void> createChild(String childId, dynamic value) async {
  _setUser(childId, value);
}

/// çocuğu databaseten siler
Future<void> deleteChild(String childId) async {
  _setUser(childId, null);
}

/// rotayı databaseten siler
Future<void> deleteRoute(String routeId) async {
  _setRoute(routeId, null);
}

/// servisi databaseten siler
Future<void> deleteShuttle(String shuttleId) async {
  _setShuttle(shuttleId, null);
}

/// görevliyi databaseten siler
Future<void> deleteEmployee(String employeeId) async {
  _setEmployee(employeeId, null);
}

/// user için unique id oluşturur, bu auth için değil bağlantı isteği içindir
Future<String> generateUserId() async {
  DataSnapshot snap = await _getUserCounter().once();
  await _increaseUserCounter();
  return "U" + snap.value.toString();
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
  _updateRouteUser(userId, routeId, {'isOn': true});
}

/// userı indirir
Future<void> userGetOff(String userId, String routeId) async {
  _updateRouteUser(userId, routeId, {'isOn': false});
}

/// bildirim yollamak için gereken cihaz tokenini user altına ekler
Future<void> addFCMToken() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  _setUserFCMToken(userId, fcmToken!, true);
}

/// bildirim yollamak için gereken cihaz tokenini user altından siler
Future<void> removeFCMToken() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  _setUserFCMToken(userId, fcmToken!, null);
}

/// userın servisi kullanıp kullanmayacağını veya geç kalacağını setler
/// ama bunu **route** altında yapar
Future<void> setRouteUse(String routeId, UserUseRoute status) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  _setUserUseRoute(userId, routeId, status);
}

/*
/// hiyerarşi:
///```
/// database
///   childCounter
///   userCounter
///   routeCounter
///   shuttleCounter
///   employees
///     employeeId
///       shuttles
///         shuttleId1
///         shuttleId2
///         ...
///   publicUserIds
///     publicUserId1: userId1
///     publicUserId2: userId2
///     ...
///   users
///     userId
///       isReal
///       name
///       surname
///       publicUserId
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
///       pendingUsers              // users waiting for user to accept connection request
///         userId1
///         userId2
///         ...
///       sentUsers
///         userId1
///         userId2
///         ...
///       sentRoutes
///         routeId1
///         routeId2
///         ...
///   shuttles
///     shuttleId
///       currentLocation
///         longtitude: ...
///         latitude: ...
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
///       startLocation
///       endLocation
///       shuttleId
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
///       pendingUsers              // users waiting shuttle employee to accept their subscription request
///         userId1
///         userId2
///         ...
///```
///
*/



/* -------YASAK ALAN BAŞLANGICI------- */

Future<void> _setUser(String userId, dynamic value) async {
  FirebaseDatabase.instance.reference().child("users/$userId").set(value);
}

Future<void> _setRoute(String routeId, dynamic value) async {
  FirebaseDatabase.instance.reference().child("routes/$routeId").set(value);
}

Future<void> _setShuttle(String shuttleId, dynamic value) async {
  FirebaseDatabase.instance.reference().child("shuttles/$shuttleId").set(value);
}

Future<void> _setEmployee(String employeeId, dynamic value) async {
  FirebaseDatabase.instance
      .reference()
      .child("employees/$employeeId")
      .set(value);
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
      .child("employees/$employeeId/shuttles/$shuttleId")
      .set(value);
}

Future<void> _setRouteUser(String routeId, String userId, dynamic value) async {
  FirebaseDatabase.instance
      .reference()
      .child("routes/$routeId/passengers/$userId")
      .set(value);
}

Future<void> _setRoutePending(
    String routeId, String userId, Request req) async {
  FirebaseDatabase.instance
      .reference()
      .child("routes/$routeId/pendingUsers/$userId")
      .set(req.value);
}

Future<void> _setUserPending(
    String toUser, String fromUser, Request req) async {
  FirebaseDatabase.instance
      .reference()
      .child("users/$toUser/pendingUsers/$fromUser")
      .set(req.value);
}

Future<void> _setSentUser(String fromUser, String toUser, Request req) async {
  FirebaseDatabase.instance
      .reference()
      .child("users/$fromUser/sentUsers/$toUser")
      .set(req.value);
}

Future<void> _setSentRoute(String userId, String routeId, Request req) async {
  FirebaseDatabase.instance
      .reference()
      .child("users/$userId/sentRoutes/$routeId")
      .set(req.value);
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

Future<void> _setUserUseRoute(
    String userId, String routeId, UserUseRoute value) async {
  FirebaseDatabase.instance
      .reference()
      .child("routes/$routeId/passengers/$userId")
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

Future<void> _increaseUserCounter() async {
  FirebaseDatabase.instance
      .reference()
      .update({"userCounter": ServerValue.increment(1)});
}

DatabaseReference _getUserCounter() {
  return FirebaseDatabase.instance.reference().child("userCounter");
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
