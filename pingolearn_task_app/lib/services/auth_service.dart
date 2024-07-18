import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../utils/util_methods.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  UserModel? _user(User? user) {
    if (user == null) {
      return null;
    }
    return UserModel(uid: user.uid, email: user.email);
  }

  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_user);
  }

  ///Sign up
  Future<UserModel?> signupNewUser(
      {required String name,
      required String email,
      required String password,
      required BuildContext context}) async {
    UserModel? user;
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = _user(_auth.currentUser);
      debugPrint("Success");
      if (result.user != null) {
        final DocumentReference doc =
            _fireStore.collection('users').doc(result.user?.uid);
        await doc.set({'name': name});
      }
      return user;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        scaffoldMessenger(context, e.message!);
      }
    }
    return user;
  }

  /// login
  Future<UserModel?> loginUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    UserModel? user;
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      debugPrint("Success");
      user = _user(result.user);
      return user;
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        scaffoldMessenger(context, e.message!);
      }
    }
    return user;
  }

  FirebaseAuth get auth => _auth;
}
