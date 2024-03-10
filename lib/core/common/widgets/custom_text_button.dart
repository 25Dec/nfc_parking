import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color textColor;

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size.zero),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        ),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        foregroundColor: MaterialStateProperty.all(textColor),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(text),
    );
  }
}
