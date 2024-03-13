import 'package:flutter/material.dart';

import '../models/recognition_model.dart';

class BoudingBox extends StatelessWidget {
  final RecognitionModel result;

  const BoudingBox({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    Color color = Colors.primaries[
        (result.label.length + result.label.codeUnitAt(0) + result.id) %
            Colors.primaries.length];

    return Positioned(
      left: result.renderLocation.left,
      top: result.renderLocation.top,
      width: result.renderLocation.width,
      height: result.renderLocation.height,
      child: Container(
        width: result.renderLocation.width,
        height: result.renderLocation.height,
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 3),
          borderRadius: const BorderRadius.all(
            Radius.circular(2),
          ),
        ),
      ),
    );
  }
}
