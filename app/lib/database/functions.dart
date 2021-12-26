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
    await FirebaseDatabase.instance
        .reference()
        .child("users/$userId/shuttles/$shuttleId")
        .set(true);
    await passenger.set(false);
    return true;
  }
  return false;
}

/// verilen id'li userı verilen id'li shuttle abonelerinden çıkarır
Future<void> removeFromShuttle(String userId, String shuttleId) async {
  await FirebaseDatabase.instance
      .reference()
      .child("users/$userId/shuttles/$shuttleId")
      .set(null);
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
Future<void> createUser(String userId, dynamic value) async {
  FirebaseDatabase.instance.reference().child("users/$userId").set(value);
}

Future<void> deleteUser(String userId) async {
  FirebaseDatabase.instance.reference().child("users/$userId").set(null);
}

/// verilend id'yi kullanıcının bağlı (children) profillerinden siler
Future<void> removeChild(String childId) async {
  String userId = FirebaseAuth.instance.currentUser!.uid;
  await FirebaseDatabase.instance
      .reference()
      .child("users/$userId/children/$childId")
      .set(null);
}

/// child için unique id/token oluşturur
Future<String> generateChildId() async {
  DatabaseReference tokenRef =
      FirebaseDatabase.instance.reference().child("childId");
  await FirebaseDatabase.instance
      .reference()
      .update({"childId": ServerValue.increment(1)});
  return "C" + (await tokenRef.once()).value.toString();
}

/// shuttle için unique id/token oluşturur
Future<String> generateShuttleId() async {
  DatabaseReference tokenRef =
      FirebaseDatabase.instance.reference().child("shuttleId");
  await FirebaseDatabase.instance
      .reference()
      .update({"shuttleId": ServerValue.increment(1)});
  return "S" + (await tokenRef.once()).value.toString();
}

/// userın shuttleda passenger olma durumunu setler
Future<void> setOnShuttle(String userId, String shuttleId, bool isOn) async {
  DatabaseReference passengers = FirebaseDatabase.instance
      .reference()
      .child("shuttles/$shuttleId/passengers");
  await passengers.update({userId: isOn});
}

/// userı shuttlea bindirir
Future<void> getOn(String userId, String shuttleId) async {
  return setOnShuttle(userId, shuttleId, true);
}

/// userı shuttledan indirir
Future<void> getOff(String userId, String shuttleId) async {
  return setOnShuttle(userId, shuttleId, false);
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
