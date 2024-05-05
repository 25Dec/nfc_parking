// ignore_for_file: unnecessary_import

import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CoreUtils {
  CoreUtils._();

  static Future<String> getAssetPath(String asset) async {
    final path = await getLocalPath(asset);
    await Directory(dirname(path)).create(recursive: true);
    final file = File(path);
    if (!await file.exists()) {
      final byteData = await rootBundle.load(asset);
      await file.writeAsBytes(
          byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    }
    return file.path;
  }

  static Future<String> getLocalPath(String path) async {
    return '${(await getApplicationSupportDirectory()).path}/$path';
  }

  static double translateX(
    double x,
    Size canvasSize,
    Size imageSize,
    InputImageRotation rotation,
    CameraLensDirection cameraLensDirection,
  ) {
    switch (rotation) {
      case InputImageRotation.rotation90deg:
        return x *
            canvasSize.width /
            (Platform.isIOS ? imageSize.width : imageSize.height);
      case InputImageRotation.rotation270deg:
        return canvasSize.width -
            x * canvasSize.width / (Platform.isIOS ? imageSize.width : imageSize.height);
      case InputImageRotation.rotation0deg:
      case InputImageRotation.rotation180deg:
        switch (cameraLensDirection) {
          case CameraLensDirection.back:
            return x * canvasSize.width / imageSize.width;
          default:
            return canvasSize.width - x * canvasSize.width / imageSize.width;
        }
    }
  }

  static double translateY(
    double y,
    Size canvasSize,
    Size imageSize,
    InputImageRotation rotation,
    CameraLensDirection cameraLensDirection,
  ) {
    switch (rotation) {
      case InputImageRotation.rotation90deg:
      case InputImageRotation.rotation270deg:
        return y *
            canvasSize.height /
            (Platform.isIOS ? imageSize.height : imageSize.width);
      case InputImageRotation.rotation0deg:
      case InputImageRotation.rotation180deg:
        return y * canvasSize.height / imageSize.height;
    }
  }

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
