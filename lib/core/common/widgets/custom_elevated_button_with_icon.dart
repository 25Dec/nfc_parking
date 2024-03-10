import 'package:flutter/material.dart';

import '../../../../core/res/app_colors.dart';

class CustomElevatedButtonWithIcon extends StatelessWidget {
  final IconData? icon;
  final String text;
  final void Function() onPressed;

  const CustomElevatedButtonWithIcon({
    super.key,
    this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          AppColors.white1,
        ),
      ),
      child: Column(
        children: [
          Icon(icon),
          const SizedBox(height: 4),
          Text(text),
        ],
      ),
    );
  }
}
