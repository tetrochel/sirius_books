import 'package:flutter/material.dart';

class NavigationController {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerState =
      GlobalKey<ScaffoldMessengerState>();

  void showSnackBar(String message) {
    ScaffoldMessenger.of(scaffoldMessengerState.currentContext!).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
