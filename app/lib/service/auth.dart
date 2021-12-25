import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> SignIn(String email,String password)async
  {
    var user = await _auth.signInWithEmailAndPassword(email: email, password: password);
    if(user.user!.emailVerified) {
      return user.user;
    }
    else {
      null;
    }
  }
  Future<void> forgotPassword(String email)async
  {
   await _auth.sendPasswordResetEmail(email: email);

  }
  SignOut()async
  {
    return await _auth.signOut();
  }
  Future<User?> SignUp(
      String name, String surname, String _email, String _password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: _email, password: _password);

    await _firestore.collection('User').doc(_auth.currentUser!.uid)
    .set({
      'Name': name,
      'Surname':surname,
      'Email': _email,

    });

    return user.user;
  }

}
