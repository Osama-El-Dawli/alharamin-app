import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.textStyle,
    this.obscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.hintStyle,
    this.validator,
    this.controller,
    this.errorText,
    this.onChanged,
  });

  final String hintText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? errorText;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      style: textStyle ?? Styles.font14W500DarkGrey,
      decoration: InputDecoration(
        errorText: errorText,
        isDense: true,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: AppColors.primary, width: 1),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(
                color: AppColors.lighterGrey,
                width: 1,
              ),
            ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: Colors.red, width: 1),
        ),
        filled: true,
        fillColor:
            backgroundColor ?? AppColors.formBackgroundGrey.withAlpha(150),
        hintText: hintText,
        hintStyle: hintStyle ?? Styles.font14W500LightGrey,
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText ?? false,
      validator: validator,
    );
  }
}
