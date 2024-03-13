import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../../core/res/app_colors.dart';

class FlashLightButton extends StatefulWidget {
  final CameraController cameraController;

  const FlashLightButton({super.key, required this.cameraController});

  @override
  State<FlashLightButton> createState() => _FlashLightButtonState();
}

class _FlashLightButtonState extends State<FlashLightButton> {
  bool turnOnFlashLight = false;

  void toggleFlashLightMode() {
    setState(() => turnOnFlashLight = !turnOnFlashLight);

    if (turnOnFlashLight) {
      widget.cameraController.setFlashMode(FlashMode.torch);
    } else {
      widget.cameraController.setFlashMode(FlashMode.off);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: toggleFlashLightMode,
      color: AppColors.white2,
      icon: Icon(
        turnOnFlashLight ? Icons.flash_on : Icons.flash_off,
      ),
    );
  }
}
