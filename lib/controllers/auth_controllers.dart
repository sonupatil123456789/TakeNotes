import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes/repository/firebase_cloudstore_db.dart';
import 'package:notes/repository/firebase_realtime%20_db.dart';
import 'package:notes/utils/listners_utils.dart';
import 'package:notes/utils/routes/routes_name.dart';
import 'package:notes/utils/seassion_manager.dart';
import '../utils/token_utils.dart';

class AuthControllers extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  FirebaseCloudStoreDataBase firebaseCloudStoreDataBase =
      FirebaseCloudStoreDataBase();
  FirebaseRealTimeDatabase firebaseRealTimeDatabase =
      FirebaseRealTimeDatabase();

  UserCredential? _loginUserData;
  UserCredential? get loginUserData => _loginUserData;

  late String _authType = "";
  String get authType => _authType;

  bool _loading = false;
  bool get loading => _loading;

  setloading(loading) {
    _loading = loading;
    notifyListeners();
  }

  // signe up with email password
  Future<String?> signUpwithEmailPassword(
      context, email, password, fullName) async {
    setloading(true);
    try {
      _loginUserData = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _loginUserData?.user?.updateDisplayName(fullName);

      await firebaseRealTimeDatabase.creatUserInRTDB(
          context, _loginUserData?.user?.uid);

      if (kDebugMode) {
        print("UserCredential EmailID >>>>>>>>>>$_loginUserData");
      }
      setloading(false);
    } on FirebaseAuthException catch (e) {
      setloading(false);
      if (kDebugMode) {
        print("error =>> $e");
      }
      if (e.code == 'email-already-in-use') {
        ListnersUtils.showFlushbarMessage(
            "This email is already in use  ",
            Colors.redAccent,
            Colors.white,
            "Please enter different email id",
            Icons.error,
            context);
      } else {
        ListnersUtils.showFlushbarMessage(
            "Error during signeing in please try again !",
            Colors.redAccent,
            Colors.white,
            "SigneUp failed",
            Icons.error,
            context);
      }
    }
    return null;
  }

  // signe in with email id
  Future<String?> signInwithEmailPassword(context, email, password) async {
    setloading(true);
    try {
      _loginUserData = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _authType = "EMAIL-PASSWORD-AUTH";

      if (_loginUserData != null) {
        dynamic data = <String, dynamic>{
          "uid": _loginUserData?.user?.uid,
          "userName": _loginUserData?.user?.displayName,
          "authType": _authType,
          "userEmail": _loginUserData?.user?.email
        };
        final generateToken = await TokenUtils.generateToken(data);
        await firebaseCloudStoreDataBase.setAuthDataToFirebase(
            _loginUserData?.user?.uid,
            <String, dynamic>{...data, "token": generateToken});

        await SeassionManager.saveObjectToSharedPreferences(
            "User", <String, dynamic>{...data, "token": generateToken});

        Navigator.pushNamed(context, RoutesName.app);

        if (kDebugMode) {
          print("UserCredential EmailID >>>>>>>>>>$_loginUserData");
        }
        setloading(false);
      }
    } on FirebaseAuthException catch (e) {
      setloading(false);
      if (kDebugMode) {
        print("error =>> $e");
      }
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        ListnersUtils.showFlushbarMessage(
            "Please enter the correct valid crediantials ",
            Colors.redAccent,
            Colors.white,
            "Invalid login crediantials",
            Icons.error,
            context);
      } else {
        ListnersUtils.showFlushbarMessage(
            "Error during logging in please try again !",
            Colors.redAccent,
            Colors.white,
            "LogIn failed",
            Icons.error,
            context);
      }
    }
    return null;
  }

  //  signe up with google in controller
  Future<String?> signInwithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      _loginUserData = await _auth.signInWithCredential(credential);
      _authType = "GOOGLE-AUTH";

      if (_loginUserData != null) {
        dynamic data = <String, dynamic>{
          "uid": _loginUserData?.user?.uid,
          "userName": _loginUserData?.user?.displayName,
          "authType": _authType,
          "userEmail": _loginUserData?.user?.email
        };

        final generateToken = await TokenUtils.generateToken(data);

        await SeassionManager.saveObjectToSharedPreferences(
            "User", <String, dynamic>{...data, "token": generateToken});
        Navigator.pushNamed(context, RoutesName.app);
        if (kDebugMode) {
          print("UserCredential GOOGLE >>>>>>>>>>${_loginUserData?.user}");
        }
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("error =>> $e");
      }
      ListnersUtils.showFlushbarMessage(
          "Error during logging in please try again !",
          Colors.redAccent,
          Colors.white,
          "LogIn failed",
          Icons.error,
          context);
    }
    return null;
  }

  Future<String?> signUpwithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      _loginUserData = await _auth.signInWithCredential(credential);
      _authType = "GOOGLE-AUTH";

      if (_loginUserData != null) {
        dynamic data = <String, dynamic>{
          "uid": _loginUserData?.user?.uid,
          "userName": _loginUserData?.user?.displayName,
          "authType": _authType,
          "userEmail": _loginUserData?.user?.email
        };

        final generateToken = await TokenUtils.generateToken(data);

        await firebaseCloudStoreDataBase.setAuthDataToFirebase(
            _loginUserData?.user?.uid,
            <String, dynamic>{...data, "token": generateToken});

                await firebaseRealTimeDatabase.creatUserInRTDB(
            context, _loginUserData?.user?.uid);

        await SeassionManager.saveObjectToSharedPreferences(
            "User", <String, dynamic>{...data, "token": generateToken});
        Navigator.pushNamed(context, RoutesName.app);
        if (kDebugMode) {
          print("UserCredential GOOGLE >>>>>>>>>>${_loginUserData?.user}");
        }
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("error =>> $e");
      }
      ListnersUtils.showFlushbarMessage(
          "Error during logging in please try again !",
          Colors.redAccent,
          Colors.white,
          "LogIn failed",
          Icons.error,
          context);
    }
    return null;
  }

  authanticateUser(context) async {
    try {
      dynamic seassion =
          await SeassionManager.getObjectFromSharedPreferences("User");
      Timer(const Duration(milliseconds: 1000), () async {
        if (kDebugMode) {
          print("token====> $seassion");
        }

        seassion?['token']  == null
            ? Navigator.pushNamed(context, RoutesName.authantication)
            : Navigator.pushNamed(context, RoutesName.app);
      });
    } catch (e) {
      if (kDebugMode) {
        print("error =>> $e");
      }
    }
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
