import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  String userId = '';

  Future signUp({required email, required password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      var creds = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var id = creds.user?.uid;
      userId = id.toString();
      // log(id.toString());

      return userId;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }
}
