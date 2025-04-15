import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.borderRadius,
    this.textStyle,
    this.buttonHeight,
    this.buttonWidth,
    this.verticalPadding,
    this.horizontalPadding,
  });

  final String text;
  final void Function() onPressed;
  final Color? backgroundColor;
  final double? borderRadius;
  final TextStyle? textStyle;
  final double? buttonHeight;
  final double? buttonWidth;
  final double? verticalPadding;
  final double? horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius?.r ?? 16.r),
          ),
        ),
        backgroundColor: WidgetStatePropertyAll(
          backgroundColor ?? AppColors.primary,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: horizontalPadding?.w ?? 22.w,
            vertical: verticalPadding?.h ?? 14.h,
          ),
        ),
        fixedSize: WidgetStatePropertyAll(
          Size(buttonHeight?.h ?? double.maxFinite, buttonWidth?.w ?? 52.h),
        ),
      ),
      onPressed: onPressed,
      child: Text(text, style: textStyle ?? Styles.font16W600White),
    );
  }
}
