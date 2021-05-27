import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void showAlert(
    BuildContext context, AlertType alertType, String title, String desc) {
  Alert(
    context: context,
    type: alertType,
    title: title,
    desc: desc,
    style: AlertStyle(
      descStyle: TextStyle(fontSize: 15),
      titleStyle: TextStyle(fontWeight: FontWeight.bold),
    ),
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () => Navigator.pop(context),
        width: 60,
        color: Colors.deepPurple,
      )
    ],
  ).show();
}
