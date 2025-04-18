import 'package:alharamin_app/core/functions/snack_bar.dart';
import 'package:alharamin_app/core/widgets/have_account.dart';
import 'package:alharamin_app/core/widgets/loading_overlay.dart';
import 'package:alharamin_app/core/widgets/registeration_header_section.dart';
import 'package:alharamin_app/core/widgets/terms_and_conditions.dart';
import 'package:alharamin_app/features/register/logic/cubits/register_cubit/register_cubit.dart';
import 'package:alharamin_app/features/register/presentation/widgets/register_form_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterScreenBody extends StatelessWidget {
  const RegisterScreenBody({super.key});

  @override
Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          snackBar(context, content: 'Registration successful');
          context.pop();
        } else if (state is RegisterFailure) {
          snackBar(context, content: state.errMessage);
        }
      },
      builder: (context, state) {
        final bool isLoading = state is RegisterLoading;
        return Stack(
          children: [
            Scaffold(
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
                      SizedBox(height: 20.h),
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
            ),
            if (isLoading) const LoadingOverlay(),
          ],
        );
      },
    );
  }
}
