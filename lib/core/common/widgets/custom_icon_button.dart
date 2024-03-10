import 'package:flutter/material.dart';

import '../../res/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final void Function() onPressed;

  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      style: IconButton.styleFrom(backgroundColor: AppColors.white7),
    );
  }
}
