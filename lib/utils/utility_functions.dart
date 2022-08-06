
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class UtilityFunctions {
  static getMyToast({required String message}) => Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_RIGHT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white.withOpacity(0.87),
        textColor: Colors.black,
        fontSize: 16.0,
      );

  static void fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  


}
// "${dateTime.day}.${dateTime.month}.${dateTime.year} ${dateTime.hour}:${dateTime.minute < 10 ? "0${dateTime.minute}" : dateTime.minute}"