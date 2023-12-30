import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CustomAlert {
  static Future<void> show(
    BuildContext context, {
    required String message,
    bool success = false,
  }) async {
    await Flushbar<dynamic>(
      message: message,
      messageText: Text(message),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(10),
      icon: success
          ? const Icon(
              Icons.notification_important,
              color: Colors.white,
            )
          : const Icon(
              Icons.error,
              color: Colors.white,
            ),
      backgroundColor: success ? Colors.green : Colors.red,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
