import 'package:flutter/material.dart';

import '../../res/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? initialValue;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        fillColor: AppColors.white1,
        filled: true,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.white3,
          fontSize: 14,
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
      validator: validator,
    );
  }
}
