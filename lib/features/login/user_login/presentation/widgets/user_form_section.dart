import 'package:alharamin_app/core/widgets/custom_button.dart';
import 'package:alharamin_app/core/widgets/custom_text_field.dart';
import 'package:alharamin_app/core/widgets/remember_me.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserFormSection extends StatefulWidget {
  const UserFormSection({super.key});

  @override
  State<UserFormSection> createState() => _UserFormSectionState();
}

class _UserFormSectionState extends State<UserFormSection> {
  final formKey = GlobalKey<FormState>();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isObsecured = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
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
            controller: passwordController,
            obscureText: isObsecured,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
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
          RememberMe(),
          SizedBox(height: 16.h),
          CustomButton(
            text: 'Login',
            onPressed: () {
              if (formKey.currentState!.validate()) {}
            },
          ),
        ],
      ),
    );
  }
}
