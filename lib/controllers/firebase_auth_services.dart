import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? get userId => _firebaseAuth.currentUser?.uid;
  String? get userEmail => _firebaseAuth.currentUser?.email;

  Future<User?> signUpEmailPass(
      String userName, String email, String pass) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: pass);
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(userName);
        user = _firebaseAuth.currentUser;
        _firestore.collection("/profile").doc(user!.uid).set({
          "u_name": userName,
          "photo_path": "",
          "follower": [],
          "following": [],
          "review_ref": [],
          "favorite": {},
          "review_count": 0,
        });
      }
      return user;
    } catch (e) {
      print("error terjadi saat signin");
      print(e);
      return null;
    }
  }

  Future<User?> loginEmailPass(String email, String pass) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: pass);
      return userCredential.user;
    } catch (e) {
      print("error terjadi saat login");
      print(e);
      return null;
    }
  }
}
