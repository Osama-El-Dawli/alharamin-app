import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/core/widgets/custom_button.dart';
import 'package:alharamin_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserFormSection extends StatefulWidget {
  const UserFormSection({super.key});

  @override
  State<UserFormSection> createState() => _UserFormSectionState();
}

class _UserFormSectionState extends State<UserFormSection> {
  final formKey = GlobalKey<FormState>();
  bool isObsecured = true;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(hintText: 'Email'),
          SizedBox(height: 16.h),
          CustomTextField(
            hintText: 'Password',
            obscureText: isObsecured,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isObsecured = !isObsecured;
                });
              },
              icon: Icon(isObsecured ? Icons.visibility : Icons.visibility_off),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
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
          ),
          SizedBox(height: 16.h),
          CustomButton(text: 'Login', onPressed: () {}),
        ],
      ),
    );
  }
}
