import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/core/widgets/custom_button.dart';
import 'package:alharamin_app/core/widgets/custom_text_field.dart';
import 'package:alharamin_app/features/register/logic/cubits/register_cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterFormSection extends StatefulWidget {
  const RegisterFormSection({super.key});

  @override
  State<RegisterFormSection> createState() => _RegisterFormSectionState();
}

class _RegisterFormSectionState extends State<RegisterFormSection> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  bool isObsecuredPassword = true;
  bool isObsecuredConfirmPassword = true;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Full Name',
            controller: nameController,
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
            controller: emailController,
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
            obscureText: isObsecuredPassword,
            suffixIcon: IconButton(
              icon: Icon(
                isObsecuredPassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  isObsecuredPassword = !isObsecuredPassword;
                });
              },
            ),
            controller: passwordController,
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
            obscureText: isObsecuredConfirmPassword,
            suffixIcon: IconButton(
              icon: Icon(
                isObsecuredConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  isObsecuredConfirmPassword = !isObsecuredConfirmPassword;
                });
              },
            ),
            controller: confirmPasswordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              } else if (value.length < 8) {
                return 'Password must be at least 8 characters';
              } else if (passwordController.text !=
                  confirmPasswordController.text) {
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
            controller: phoneNumberController,
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
            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 20.h),
          CustomButton(
            text: 'Create Account',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<RegisterCubit>().register(
                  fullName: nameController.text.trim(),
                  email: emailController.text.trim(),
                  password: passwordController.text,
                  phone: phoneNumberController.text.trim(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
