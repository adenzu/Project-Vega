import 'package:firebase_database/firebase_database.dart';

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


/// hiyerarşi:
///```
/// database
///   shuttles
///     shuttleId
///       passengers
///         userId
/// ```