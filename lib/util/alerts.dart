import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class Alerts {
  static Future<void> showAlert(
      bool success, BuildContext context, String msg) async {
    if (success) {
      await QuickAlert.show(
          confirmBtnColor: Colors.green,
          context: context,
          text: msg,
          type: QuickAlertType.success);
    } else {
      await QuickAlert.show(
          confirmBtnColor: Colors.red,
          context: context,
          text: msg,
          type: QuickAlertType.error);
    }
  }
}
