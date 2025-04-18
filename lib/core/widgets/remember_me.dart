import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RememberMe extends StatelessWidget {
  const RememberMe({super.key, required this.value, required this.onChanged});

  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
          hoverColor: AppColors.primary,
          activeColor: AppColors.primary,
          value: value,
          onChanged: onChanged,
        ),
        Text('Remember me', style: Styles.font14W400Grey),
      ],
    );
  }
}
