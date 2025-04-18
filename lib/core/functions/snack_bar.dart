import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

void snackBar(BuildContext context, {required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(content, style: TextStyle(color: AppColors.primary)),
      backgroundColor: AppColors.lighterGrey,
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(30),
    ),
  );
}
