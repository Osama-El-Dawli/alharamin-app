import 'package:alharamin_app/core/widgets/custom_button.dart';
import 'package:alharamin_app/core/widgets/custom_text_field.dart';
import 'package:alharamin_app/core/widgets/remember_me.dart';
import 'package:alharamin_app/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserFormSection extends StatelessWidget {
  UserFormSection({super.key});
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
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
            // obscureText: isObsecured,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          RememberMe(),
          SizedBox(height: 16.h),
          CustomButton(
            text: 'Login',
            onPressed: () {
              if (authCubit.loginFormKey.currentState!.validate()) {
                authCubit.login();
              }
            },
          ),
        ],
      ),
    );
  }
}
