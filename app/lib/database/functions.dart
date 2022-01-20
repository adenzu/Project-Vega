import 'dart:io';

import 'package:app/database/request.dart';
import 'package:app/database/user_use_route.dart';
import 'package:app/general/util.dart';
import 'package:app/shuttle_creation/shuttle_info_class.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';

/// verilen shuttle id'yi kullanıcının servislerine ekler
Future<void> addShuttle(String plate, int seatCount) async {
  String userId = getUserId();
  String shuttleId = await generateShuttleId();
  _setShuttle(shuttleId, {
    "employees": {userId: true},
    "plate": plate,
    "seatCount": seatCount,
    "info": "Bilgi bulunmamakta.",
  });
  _setPlate(plate, shuttleId);
  _setEmployeeShuttle(userId, shuttleId, true);
}

/// verilen shuttle id'yi kullanıcının servislerinden siler
@Deprecated("Bu fonksiyon servisi siler. `leaveShuttle` kullan")
Future<void> removeShuttle(String shuttleId) async {
  String userId = getUserId();
  _setEmployeeShuttle(userId, shuttleId, null);
}

Future<void> leaveShuttle(String shuttleId) async {
  String userId = getUserId();
  _setShuttleEmployee(shuttleId, userId, null);
  _setEmployeeShuttle(userId, shuttleId, null);
}

/// rotaya abone olur
@Deprecated(
    "Bu fonksiyon görevliye sormadan kullanıcıyı rotaya abone eder. `requestRouteSub` kullan")
Future<void> subRoute(String routeId) async {
  String userId = getUserId();
  _setUserRoute(userId, routeId, true);
  _setRouteUser(routeId, userId, {'isOn': false, 'status': 0});
}

/// çocuğu rotaya abone eder
@Deprecated(
    "Bu fonksiyon görevliye sormadan çocuğu rotaya abone eder. `requestChildRouteSub` kullan")
Future<void> childSubRoute(String childId, String routeId) async {
  _setUserRoute(childId, routeId, true);
  _setRouteUser(routeId, childId, {'isOn': false, 'status': 0});
}

/// rotaya abone olma isteği yollar
Future<void> requestRouteSub(String routeId, {String userId = ''}) async {
  userId = userId == '' ? getUserId() : userId;
  _setSentRoute(userId, routeId, Request.pending);
}

/// rotaya abone olma isteği yollar
Future<void> requestChildRouteSub(String childId, String routeId) async {
  _setSentRoute(childId, routeId, Request.pending);
}

/// rotaya abonelikten çıkar
Future<void> unsubRoute(String routeId) async {
  String userId = getUserId();
  _setUserRoute(userId, routeId, null);
  _setRouteUser(routeId, userId, null);
}

/// çocuğu rotaya abonelikten çıkar
Future<void> childUnsubRoute(String childId, String routeId) async {
  _setUserRoute(childId, routeId, null);
  _setRouteUser(routeId, childId, null);
}

/// kullanıcıyı rota aboneliklerinden çıkartır
///
/// aslında `childUnsubRoute` kullanıyor ama çaktırma :)
Future<void> removePassenger(String passengerId, String routeId) async {
  childUnsubRoute(passengerId, routeId);
}

/// `userId` id'li kullanıcıya onu "çocuk" profili olarak ekleme isteği yollar
Future<void> requestConnection(String userId) async {
  String currentUserId = getUserId();
  _setSentUser(currentUserId, userId, Request.pending);
}

Future<void> cancelConnectionRequest(String userId) async {
  String currentUserId = getUserId();
  _setSentUser(currentUserId, userId, Request.canceled);
}

Future<void> respondToConnectionRequest(String userId, Request req) async {
  String currentUserId = getUserId();
  _setUserPending(currentUserId, userId, req);
}

Future<void> requestShuttleEmployee(String shuttleId) async {
  String userId = getUserId();
  _setSentShuttle(userId, shuttleId, Request.pending);
}

Future<DataSnapshot> getUserData({String userId = ''}) async {
  if (userId == '') {
    userId = getUserId();
  }
  DatabaseReference userRef =
      FirebaseDatabase.instance.reference().child("users/$userId");
  DataSnapshot userData = await userRef.once();
  return userData;
}

Future<Map<String, dynamic>> getUserDataValue({String userId = ''}) async {
  return Map<String, dynamic>.from((await getUserData(userId: userId)).value);
}

/// verilen id'yi kullanıcının bağlı (children) profillerine ekler
Future<void> addChild(String childId) async {
  String userId = getUserId();
  _setUserParent(childId, userId, true);
  _setUserChild(userId, childId, true);
}

/// verilen id'yi kullanıcının bağlı (children) profillerinden siler
Future<void> removeChild(String childId) async {
  String userId = getUserId();
  _setUserParent(childId, childId, null);
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

Future<void> acceptEmployee(String shuttleId, String userId) async {
  _setShuttlePendingEmployee(shuttleId, userId, Request.accept);
}

Future<void> rejectEmployee(String shuttleId, String userId) async {
  _setShuttlePendingEmployee(shuttleId, userId, Request.reject);
}

/// user için unique id oluşturur, bu auth için değil bağlantı isteği içindir
Future<String> generateUserId() async {
  DataSnapshot snap = await _getUserCounter().once();
  await _increaseUserCounter();
  return "U" + (snap.value ?? 0).toString();
}

/// child için unique id oluşturur
Future<String> generateChildId() async {
  DataSnapshot snap = await _getChildCounter().once();
  await _increaseChildCounter();
  return "C" + (snap.value ?? 0).toString();
}

/// shuttle için unique id oluşturur
Future<String> generateShuttleId() async {
  DataSnapshot snap = await _getShuttleCounter().once();
  await _increaseShuttleCounter();
  return "S" + (snap.value ?? 0).toString();
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
  String userId = getUserId();
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  _setUserFCMToken(userId, fcmToken!, true);
}

/// bildirim yollamak için gereken cihaz tokenini user altından siler
Future<void> removeFCMToken() async {
  String userId = getUserId();
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  _setUserFCMToken(userId, fcmToken!, null);
}

/// userın servisi kullanıp kullanmayacağını veya geç kalacağını setler
/// ama bunu **route** altında yapar
Future<void> setRouteUse(String routeId, UserUseRoute status) async {
  String userId = getUserId();
  _setUserUseRoute(userId, routeId, status);
}

Future<void> addRoute(String shuttleId) async {
  String routeId = await generateRouteId();
  _setRoute(routeId, {'shuttleId': shuttleId});
  _setShuttleRoute(shuttleId, routeId, false);
}

Future<void> removeRoute(String shuttleId, String routeId) async {
  _setShuttleRoute(shuttleId, routeId, null);
  _setRoute(routeId, null);
}

Future<bool> checkShuttleExists(String shuttleId) async {
  return (await FirebaseDatabase.instance
          .reference()
          .child("shuttles/$shuttleId")
          .once())
      .exists;
}

Future<bool> checkRouteExists(String routeId) async {
  return (await FirebaseDatabase.instance
          .reference()
          .child("routes/$routeId")
          .once())
      .exists;
}

Future<bool> checkUserExists(String userId) async {
  return (await FirebaseDatabase.instance
          .reference()
          .child("publicUserIds/$userId")
          .once())
      .exists;
}

Future<bool> checkChildExists(String childId) async {
  return (await FirebaseDatabase.instance
          .reference()
          .child("users/${getUserId()}/children/$childId")
          .once())
      .exists;
}

Future<bool> checkPlateExists(String plate) async {
  return (await FirebaseDatabase.instance
          .reference()
          .child("plates/$plate")
          .once())
      .exists;
}

Future<bool> isUserReal(String userId) async {
  return (await FirebaseDatabase()
          .reference()
          .child("users/$userId/isReal")
          .once())
      .value;
}

Future<String> getPublicId(String userId) async {
  return (await FirebaseDatabase.instance
          .reference()
          .child("users/$userId/publicId")
          .once())
      .value;
}

Future<int> concurrentPassengerCount(String shuttleId) async {
  Map<String, bool>? routes = (await FirebaseDatabase.instance
          .reference()
          .child("shuttles/$shuttleId/rotues")
          .once())
      .value;

  if (routes == null) {
    return 0;
  }

  late String currentRoute;

  routes.forEach((key, value) {
    if (value == true) {
      currentRoute = key;
    }
  });

  Map<String, dynamic> passengers = (await FirebaseDatabase.instance
          .reference()
          .child("routes/$currentRoute/passengers")
          .once())
      .value;

  return passengers.length;
}

Future<void> setShuttleInfo(String shuttleId, String shuttleInfo) async {
  FirebaseDatabase.instance
      .reference()
      .child("shuttles/$shuttleId/info")
      .set(shuttleInfo);
}

Future<void> removeEmployee(String shuttleId, String employeeId) async {
  FirebaseDatabase.instance
      .reference()
      .child("shuttles/$shuttleId/employees/$employeeId")
      .set(null);
  FirebaseDatabase.instance
      .reference()
      .child("employees/$employeeId/shuttles/$shuttleId")
      .set(null);
}

Future<void> uploadProfilePicture(File image, {String userId = ''}) async {
  if (userId == '') {
    userId == getUserId();
  }
  await FirebaseStorage.instance.ref("profilePictures/$userId").putFile(image);
}

Future<void> setShuttleLocation(
    String shuttleId, double longitude, double latitude) async {
  DatabaseReference shuttleRef =
      FirebaseDatabase.instance.reference().child("shuttles/$shuttleId");
  shuttleRef.child("longitude").set(longitude);
  shuttleRef.child("latitude").set(latitude);
}

Future<List<String>?> getUserRoutes({String userId = ''}) async {
  if (userId == '') {
    userId = getUserId();
  }
  DataSnapshot routesData = await FirebaseDatabase.instance
      .reference()
      .child("users/$userId/routes")
      .once();
  return Map<String, bool>.from(routesData.value ?? {}).keys.toList();
}

/*
/// hiyerarşi:
///```
/// database
///   childCounter
///   userCounter
///   routeCounter
///   shuttleCounter
///   plates
///     plate1: shuttleId1
///     plate2: shuttleId2
///   employees
///     employeeId
///       shuttles
///         shuttleId1
///         shuttleId2
///         ...
///       sentShuttles
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
///       info
///       publicId
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
///       notifications
///         childUpdate: true       // should notificate
///         shuttleClose: false     // should not
///         ...
///   shuttles
///     shuttleId
///       plate
///       seatCount
///       info
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
///       pendingUsers
///         userId1
///         userId2
///         ...
///       pendingEmployees
///         employeeId1
///         employeeId2
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

Future<void> _setShuttleRoute(
    String shuttleId, String routeId, dynamic value) async {
  FirebaseDatabase.instance
      .reference()
      .child("shuttles/$shuttleId/routes/$routeId")
      .set(value);
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

Future<void> _setPlate(String plate, String shuttleId) async {
  FirebaseDatabase.instance.reference().child("plates/$plate").set(shuttleId);
}

Future<void> _setShuttleEmployee(
    String shuttleId, String employeeId, dynamic value) async {
  FirebaseDatabase.instance
      .reference()
      .child("shuttles/$shuttleId/employees/$employeeId")
      .set(value);
}

Future<void> _setShuttlePendingEmployee(
    String shuttleId, String userId, Request req) async {
  FirebaseDatabase.instance
      .reference()
      .child("shuttles/$shuttleId/pendingEmployees/$userId")
      .set(req.value);
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

Future<void> _setSentShuttle(
    String userId, String shuttleId, Request req) async {
  FirebaseDatabase.instance
      .reference()
      .child("employees/$userId/sentShuttles/$shuttleId")
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

Future<void> _setUserParent(
    String userId, String parentId, dynamic value) async {
  FirebaseDatabase.instance
      .reference()
      .child("users/$userId/parents/$parentId")
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
