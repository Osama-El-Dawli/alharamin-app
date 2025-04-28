import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.textStyle,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.hintStyle,
    this.validator,
    this.controller,
    this.errorText,
    this.onChanged,
    this.labelText,
    this.labelStyle,
    this.keyboardType,
    this.prefixIconConstraints,
    this.inputFormatters,
    this.onFieldSubmitted,
  });

  final String? hintText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? errorText;
  final String? labelText;
  final TextInputType? keyboardType;
  final BoxConstraints? prefixIconConstraints;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObsecured = false;

  @override
  void initState() {
    _isObsecured = widget.obscureText ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType ?? TextInputType.text,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      controller: widget.controller,
      style: widget.textStyle ?? Styles.font14W500DarkGrey,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: widget.labelStyle ?? Styles.font14W500Grey,
        errorText: widget.errorText,
        prefixIconConstraints: widget.prefixIconConstraints,
        isDense: true,
        contentPadding:
            widget.contentPadding ??
            EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        focusedBorder:
            widget.focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: const BorderSide(color: AppColors.primary, width: 1),
            ),
        enabledBorder:
            widget.enabledBorder ??
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
            widget.backgroundColor ??
            AppColors.formBackgroundGrey.withAlpha(200),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? Styles.font14W500LightGrey,
        suffixIcon:
            widget.obscureText == true
                ? IconButton(
                  icon: Icon(
                    _isObsecured ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObsecured = !_isObsecured;
                    });
                  },
                )
                : widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
      ),
      obscureText: _isObsecured,
      validator: widget.validator,
    );
  }
}
