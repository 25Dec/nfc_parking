import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  final BuildContext context;

  AppTheme(this.context);

  ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.green,
        background: AppColors.white2,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
