import 'dart:io';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../../../../core/res/app_colors.dart';
import '../../../../core/utils/core_utils.dart';

class ObjectDetectorPainter extends CustomPainter {
  final List<DetectedObject> objects;
  final RecognizedText recognizedText;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;

  ObjectDetectorPainter(
    this.objects,
    this.recognizedText,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = AppColors.green;

    final Paint background = Paint()..color = const Color(0x99000000);

    for (final DetectedObject detectedObject in objects) {
      final ParagraphBuilder builder = ParagraphBuilder(
        ParagraphStyle(
          textAlign: TextAlign.left,
          fontSize: 16,
          textDirection: TextDirection.ltr,
        ),
      );

      builder.pushStyle(
        ui.TextStyle(
          color: AppColors.green,
          background: background,
        ),
      );

      if (detectedObject.labels.isNotEmpty) {
        final label =
            detectedObject.labels.reduce((a, b) => a.confidence > b.confidence ? a : b);

        // if (label.text == "Home good") {
        for (final textBlock in recognizedText.blocks) {
          builder.addText(textBlock.text);

          final List<Offset> cornerPoints = <Offset>[];
          for (final point in textBlock.cornerPoints) {
            double x = CoreUtils.translateX(
              point.x.toDouble(),
              size,
              imageSize,
              rotation,
              cameraLensDirection,
            );
            double y = CoreUtils.translateY(
              point.y.toDouble(),
              size,
              imageSize,
              rotation,
              cameraLensDirection,
            );

            if (Platform.isAndroid) {
              switch (rotation) {
                case InputImageRotation.rotation0deg:
                case InputImageRotation.rotation270deg:
                  break;
                case InputImageRotation.rotation180deg:
                  x = size.width - x;
                  y = size.height - y;
                  break;
                case InputImageRotation.rotation90deg:
                  x = size.width -
                      CoreUtils.translateX(
                        point.y.toDouble(),
                        size,
                        imageSize,
                        rotation,
                        cameraLensDirection,
                      );
                  y = CoreUtils.translateY(
                    point.x.toDouble(),
                    size,
                    imageSize,
                    rotation,
                    cameraLensDirection,
                  );
                  break;
              }
            }

            cornerPoints.add(Offset(x, y));
          }

          cornerPoints.add(cornerPoints.first);
          canvas.drawPoints(PointMode.polygon, cornerPoints, paint);
        }
        // }
      }

      builder.pop();

      final left = CoreUtils.translateX(
        detectedObject.boundingBox.left,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );

      final top = CoreUtils.translateY(
        detectedObject.boundingBox.top,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );

      final right = CoreUtils.translateX(
        detectedObject.boundingBox.right,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );

      final bottom = CoreUtils.translateY(
        detectedObject.boundingBox.bottom,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );

      canvas.drawRect(
        Rect.fromLTRB(left, top, right, bottom),
        paint,
      );

      canvas.drawParagraph(
        builder.build()
          ..layout(
            ParagraphConstraints(width: (right - left).abs()),
          ),
        Offset(
            Platform.isAndroid && cameraLensDirection == CameraLensDirection.front
                ? right
                : left,
            top),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
