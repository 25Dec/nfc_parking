import 'dart:math';

import 'package:flutter/material.dart';

class CoreUtils {
  CoreUtils._();

  static String generateRandomId() {
    String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    final random = Random.secure();
    return String.fromCharCodes(
      Iterable.generate(
        12,
        (_) => str.codeUnitAt(
          random.nextInt(str.length),
        ),
      ),
    );
  }

  static bool validatePhoneNumber(String phoneNumber) {
    final phoneRegex =
        RegExp(r'^(0?)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])[0-9]{7}$');
    return phoneRegex.hasMatch(phoneNumber);
  }

  static bool validatePassword(String password) {
    final passwordRegex = RegExp(r'^(?!.* ).{6,32}$');
    return passwordRegex.hasMatch(password);
  }

  static bool validateEmail(String email) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    return emailRegex.hasMatch(email);
  }

  static Future<bool?> showCustomDialog(
    BuildContext context, {
    required String title,
    required String content,
    String? dismissText,
    required String confirmText,
    void Function()? onDismiss,
    void Function()? onConfirm,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          content: Text(content),
          actions: [
            if (dismissText != null)
              TextButton(
                child: Text(dismissText),
                onPressed: () {
                  onDismiss != null ? onDismiss() : () {};
                  Navigator.of(context).pop(false);
                },
              ),
            TextButton(
              child: Text(confirmText),
              onPressed: () {
                onConfirm != null ? onConfirm() : () {};
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }
}
