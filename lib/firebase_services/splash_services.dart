import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_mini_app/utils/routes.dart';
import 'package:flutter/material.dart';

class SplashServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void isLogin(BuildContext context) {
    if (_auth.currentUser == null) {
      Timer(const Duration(seconds: 3),
          () => Navigator.pushReplacementNamed(context, MyRoutes.loginRoute));
    } else {
      Timer(const Duration(seconds: 3),
          () => Navigator.pushReplacementNamed(context, MyRoutes.homeRoute));
    }
  }
}
