import 'package:alharamin_app/core/widgets/terms_and_conditions.dart';
import 'package:alharamin_app/core/widgets/have_account.dart';
import 'package:alharamin_app/features/login/user_login/presentation/widgets/user_form_section.dart';
import 'package:alharamin_app/features/login/user_login/presentation/widgets/user_header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserLoginBody extends StatelessWidget {
  const UserLoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserHeaderSection(),
              UserFormSection(),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: TermsAndConditions(),
              ),
              SizedBox(height: 24.h),
              HaveAccount(
                questionText: 'Don\'t have an account?',
                buttonText: 'Sign Up',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
