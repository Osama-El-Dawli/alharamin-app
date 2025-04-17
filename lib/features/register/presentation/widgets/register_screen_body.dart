import 'package:alharamin_app/core/widgets/have_account.dart';
import 'package:alharamin_app/core/widgets/registeration_header_section.dart';
import 'package:alharamin_app/core/widgets/terms_and_conditions.dart';
import 'package:alharamin_app/features/register/presentation/widgets/register_form_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              RegisterationHeaderSection(
                headerTitle: 'Create Account',
                headerSubTitle:
                    'Sign up now and start exploring all that our app has to offer. We\'re excited to welcome you to our community!',
              ),
              RegisterFormSection(),
              SizedBox(height: 18.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: TermsAndConditions(),
              ),
              SizedBox(height: 8.h),
              HaveAccount(
                questionText: 'Already have an account?',
                buttonText: 'Sign In',
                onPressed: () {
                  context.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
