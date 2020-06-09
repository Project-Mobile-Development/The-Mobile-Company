import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_rectangle/Models/user_model.dart';
import 'package:hello_rectangle/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, firstName: user.displayName) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
          .map(_userFromFirebaseUser);
  }

  // sign in anonymous
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in with email and password
  Future signInWitEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

// register with email and password
  Future registerWithEmailAndPassword(String email, String password, String firstName, String lastName, String phoneNumber) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      // create a new document for the new user with the uid
      await DatabaseService(uid: user.uid).updateUserData(firstName, lastName, email, password, phoneNumber, 'https://firebasestorage.googleapis.com/v0/b/boat2me-1232a.appspot.com/o/personal-user-illustration-%402x.png?alt=media&token=0e972675-1d93-4b7d-aed4-e85689d47398');
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

// sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}
