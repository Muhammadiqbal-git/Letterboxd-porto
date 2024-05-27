import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signUpEmailPass(String userName, String email, String pass) async{
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(userName);
        user = _firebaseAuth.currentUser;
      }
      return user;
    } catch (e) {
      print("error terjadi saat signin");
      print(e);
      return null;
    }
  }

  Future<User?> loginEmailPass(String email, String pass)async{
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);
      return userCredential.user;
    } catch (e) {
      print("error terjadi saat login");
      print(e);
      return null;
    }
  }
}