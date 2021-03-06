import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthImpl {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<String> getCurrentUser();
  Future<void> signOut();
  String getUID();
}

class Auth implements AuthImpl {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String uid = '----';
  String email = '';
  String getUID() {
    return uid;
  }

  String getEmail() {
    return email;
  }

  Future<String> signIn(String email, String password) async {
    this.email = email;
    UserCredential profile = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return profile.user!.uid;
  }

  Future<String> signUp(String email, String password) async {
    this.email = email;
    UserCredential profile = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return profile.user!.uid;
  }

  Future<String> getCurrentUser() async {
    var user = _firebaseAuth.currentUser;
    if (user == null) return uid;
    uid = user.uid;
    email = user.email!;
    return uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
