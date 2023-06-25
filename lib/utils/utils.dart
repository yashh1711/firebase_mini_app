import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  void toastErrorMessage(String message) {
    Fluttertoast.showToast(
        msg: message, backgroundColor: Colors.red, textColor: Colors.white);
  }

  void toastCompleteMessage(String message) {
    Fluttertoast.showToast(
        msg: message, backgroundColor: Colors.green, textColor: Colors.white);
  }
}
