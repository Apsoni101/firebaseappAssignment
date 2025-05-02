import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static final TextStyle title = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    color: AppColors.title,
    fontSize: 35,
    letterSpacing: 0,
    height: 1.35,
  );
  static final TextStyle trailing = const TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
  );
  static final TextStyle register = const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
  );
}
