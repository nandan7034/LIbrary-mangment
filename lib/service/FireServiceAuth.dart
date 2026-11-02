import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/model/authmodel.dart';
import 'package:flutter_application_1/model/usermodel.dart';

class FireserviceA {
  Future<User?> CreateUser(UserModel user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email.toString(),
            password: user.password.toString(),
          );
      return userCredential.user;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<User?> AdminUser(UserModel user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email.toString(),
            password: user.password.toString(),
          );
      return userCredential.user;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<UserCredential?> logUser(AuthModel authh) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: authh.email.toString(),
        password: authh.password.toString(),
      );  
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<UserCredential?> Registeruser(AuthModel auth) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: auth.email.toString(),
            password: auth.password.toString(),
          );
      return userCredential;
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> Signout() async {
    try {
     await FirebaseAuth.instance.signOut();
    } catch (e) {
      log(e.toString());
    }
  }
}
