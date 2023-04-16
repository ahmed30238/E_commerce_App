import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum ToastStates { successState, warningState, errorState }

Color toastColor(ToastStates toastStates) {
  Color color;
  switch (toastStates) {
    case ToastStates.successState:
      color = Colors.green;
      break;
    case ToastStates.warningState:
      color = Colors.amber;
      break;
    case ToastStates.errorState:
      color = Colors.red;
      break;
  }
  return color;
}

void showToast({
  required String msg,
  required ToastStates states,
}) =>
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: toastColor(states),
      textColor: Colors.white,
    );
