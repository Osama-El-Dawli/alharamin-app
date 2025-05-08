import 'package:alharamin_app/core/widgets/custom_button.dart';
import 'package:alharamin_app/core/widgets/custom_text_field.dart';
import 'package:alharamin_app/core/widgets/remember_me.dart';
import 'package:alharamin_app/features/auth/data/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserFormSection extends StatefulWidget {
  const UserFormSection({super.key});

  @override
  State<UserFormSection> createState() => _UserFormSectionState();
}

class _UserFormSectionState extends State<UserFormSection> {
  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Form(
      key: authCubit.loginFormKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: 'Email',
            onChanged: (email) {
              authCubit.email = email.trim();
            },
            controller: authCubit.emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!_emailRegex.hasMatch(value.trim())) {
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
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          RememberMe(
            initialValue: _rememberMe,
            onChanged: (newValue) {
              setState(() {
                _rememberMe = newValue;
              });
              authCubit.rememberMe = newValue; 
            },
          ),
          SizedBox(height: 16.h),
          CustomButton(
            text: 'Login',
            onPressed: () {
              if (authCubit.loginFormKey.currentState!.validate()) {
                authCubit.rememberMe = _rememberMe; 
                authCubit.login();
              }
            },
          ),
        ],
      ),
    );
  }
}
