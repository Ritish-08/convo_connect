import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey, width: 2),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey, width: 2),
  ),
  //eror border tab kaam krega jab validator issue hoega
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 2),
  ),
);
//inplace of navigator.push
void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

void showSnackbar(context, color, dynamic message) {
  String errorMessage = '';

  if (message is String) {
    errorMessage = message;
  } else if (message is FirebaseAuthException) {
    //if message is a FirebaseAuthException, it sets errorMessage to the message property of the exception.
    errorMessage = message.message ?? 'Authentication error';
  } else {
    errorMessage = 'An unexpected error occurred';
  }

  try {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMessage,
          style: TextStyle(fontSize: 14),
        ),
        backgroundColor: color,
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
          textColor: Colors.white,
        ),
      ),
    );
  } catch (e) {
    print('Error showing Snackbar: $e');
  }
}
