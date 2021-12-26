import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

/// verilen shuttle id'yi kullanıcının servislerine ekler
///
/// NOT: bu fonksiyon kullanıcıyı servise abone etmez!
///      kullanıcıyı shuttleEmployees altına alıp shuttle'ı da
///      servisi olarak ekler
Future<void> addShuttle(String shuttleId) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  FirebaseDatabase.instance
      .reference()
      .child("shuttleEmployees/$userId/shuttles/$shuttleId")
      .set(true);
}

/// verilen shuttle id'yi kullanıcının servislerinden siler
///
/// NOT: bu fonksiyon kullanıcının servis aboneliğini silmez!
///      shuttleEmployees altındaki kullanıcının servislerinden
///      verilen id'yi siler
Future<void> removeShuttle(String shuttleId) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  FirebaseDatabase.instance
      .reference()
      .child("shuttleEmployees/$userId/shuttles/$shuttleId")
      .set(null);
}

/// verilen id'li userı verilen id'li suhttle'a abone eder
/// başarılı olursa `true` olmazsa `false` döner
Future<bool> subscribeToShuttle(String userId, String shuttleId) async {
  DatabaseReference passenger = FirebaseDatabase.instance
      .reference()
      .child("shuttles/$shuttleId/passengers/$userId");

  if (!(await passenger.once()).exists) {
    await passenger.set(false);
    return true;
  }
  return false;
}

/// verilen id'li userı verilen id'li shuttle abonelerinden çıkarır
Future<void> removeFromShuttle(String userId, String shuttleId) async {
  await FirebaseDatabase.instance
      .reference()
      .child("shuttles/$shuttleId/passengers/$userId")
      .set(null);
}

/// verilend id'yi kullanıcının bağlı (children) profillerine ekler
Future<void> addChild(String childId) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  await FirebaseDatabase.instance
      .reference()
      .child("users/$userId/children/$childId")
      .set(true);
}

/// verilen id ve isim ve soy isim ile user oluşturur
Future<void> createUser(
    String userId, String userName, String userSurname) async {
  FirebaseDatabase.instance
      .reference()
      .child("users/$userId")
      .set({"name": userName, "surname": userSurname});
}

Future<void> updateUserInfo(Map<String, dynamic> newInfo) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  await FirebaseDatabase.instance.reference().child(userId).update(newInfo);
}

/// verilend id'yi kullanıcının bağlı (children) profillerinden siler
Future<void> removeChild(String childId) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  await FirebaseDatabase.instance
      .reference()
      .child("users/$userId/children/$childId")
      .set(null);
}

/// user için unique id/token oluşturur
Future<int> generateUserToken() async {
  DatabaseReference tokenRef =
      FirebaseDatabase.instance.reference().child("userToken");
  // if (!(await tokenRef.once()).exists) {
  //   await tokenRef.set(0);
  //   return 0;
  // }
  await FirebaseDatabase.instance
      .reference()
      .update({"userToken": ServerValue.increment(1)});
  return (await tokenRef.once()).value;
}

Future<List<String>> getChildrenIds() async {
  String userId = FirebaseAuth.instance.currentUser!.uid;

  return ((await FirebaseDatabase.instance
              .reference()
              .child("users/$userId/children")
              .once())
          .value as Map<String, String>)
      .keys
      .toList();
}

Future<Map<String, dynamic>> getUserInfo(String userId) async {
  return (await FirebaseDatabase.instance
          .reference()
          .child("users/$userId")
          .once())
      .value;
}

/// hiyerarşi:
///```
/// database
///   shuttleEmployees
///     employeeId
///       shuttles
///         shuttleId
///   users
///     userId
///       children
///         childId
///   shuttles
///     shuttleId
///       passengers
///         userId
/// ```