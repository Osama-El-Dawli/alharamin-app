import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/core/widgets/custom_button.dart';
import 'package:alharamin_app/core/widgets/custom_text_field.dart';
import 'package:alharamin_app/features/auth/data/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterFormSection extends StatelessWidget {
  RegisterFormSection({super.key});
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    return Form(
      key: authCubit.registerFormKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Full Name',
            onChanged: (fullName) {
              authCubit.fullName = fullName.trim();
            },
            controller: authCubit.fullNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            hintText: 'Email',
            onChanged: (email) {
              authCubit.email = email.trim();
            },
            controller: authCubit.emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!emailRegex.hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            hintText: 'Password',
            obscureText: true,
            onChanged: (password) {
              authCubit.password = password;
            },
            controller: authCubit.passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              } else if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            hintText: 'Confirm Password',
            obscureText: true,
            controller: authCubit.confirmPasswordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              } else if (value.length < 8) {
                return 'Password must be at least 8 characters';
              } else if (authCubit.passwordController.text !=
                  authCubit.confirmPasswordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            hintText: 'Phone Number',
            onChanged: (phone) {
              authCubit.phone = phone;
            },
            controller: authCubit.phoneController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              } else if (value.length != 11) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🇪🇬 ', style: TextStyle(fontSize: 24)),
                  Text(
                    '+2',
                    style: Styles.font14W500LightGrey.copyWith(
                      color: AppColors.grey,
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    color: AppColors.lightGrey,
                    height: 24.h,
                    width: 1.w,
                  ),
                ],
              ),
            ),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 20.h),
          CustomButton(
            text: 'Create Account',
            onPressed: () {
              if (authCubit.registerFormKey.currentState!.validate()) {
                authCubit.register();
              }
            },
          ),
        ],
      ),
    );
  }
}
