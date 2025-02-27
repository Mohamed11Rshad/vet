import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Models/User.dart';

extension NavigationExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double get screenHeight => screenSize.height;

  double get screenWidth => screenSize.width;

  // Navigation
  void navigateTo(Widget screen) {
    Navigator.push(
      this,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.easeInCirc;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  void navigateFromSplash(Widget screen) {
    Navigator.pushReplacement(
      this,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.easeInCirc;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  void routeTo(String name) {
    Navigator.of(this).pushNamed(name);
  }

  //Alerts
  void showAlert({String title = '', String message = ''}) {
    showDialog(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
                fontFamily: 'fira', fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Text(
            message,
            style: TextStyle(
                fontFamily: 'fira',
                fontSize: 13,
                fontWeight: FontWeight.normal),
          ),
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.grey.shade200),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)))),
              child: Text(
                "موافق",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<T?> navigateWithData<T>(Widget widget) {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(builder: (context) => widget),
    );
  }
}

//Auth
extension EmailValidator on String {
  bool isValidEmail() {
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(this);
  }

  bool isValidName() {
    final RegExp regex = RegExp(r'^[\p{L}\s]{3,15}$', unicode: true);
    return regex.hasMatch(this);
  }

  bool isValidNumber() {
    final RegExp regex = RegExp(r'^[\p{N}]{3,20}$', unicode: true);
    return regex.hasMatch(this);
  }

// bool isStrongPassword() {
//   final RegExp regex = RegExp(r'^\s*.{8}\s*$');
//   print("is Strong");
//   print(regex.hasMatch(this));
//   return regex.hasMatch(this);
// }
}

extension StringExtension on String? {
  bool get isNotEmptyOrNull => this != null && this!.isNotEmpty;
}
