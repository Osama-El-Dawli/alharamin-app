import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RememberMe extends StatefulWidget {
  const RememberMe({super.key});

  @override
  State<RememberMe> createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
    bool isChecked = false;

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
                onChanged:
                    (value) => setState(() => isChecked = value ?? false),
                value: isChecked,
              ),
              Text('Remember me', style: Styles.font14W400Grey),
            ],
          );
  }
}