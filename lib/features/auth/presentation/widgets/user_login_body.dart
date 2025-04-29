import 'package:alharamin_app/core/functions/flutter_toast.dart';
import 'package:alharamin_app/core/routes/app_routes.dart';
import 'package:alharamin_app/core/widgets/have_account.dart';
import 'package:alharamin_app/core/widgets/loading_overlay.dart';
import 'package:alharamin_app/core/widgets/registeration_header_section.dart';
import 'package:alharamin_app/core/widgets/terms_and_conditions.dart';
import 'package:alharamin_app/features/auth/cubit/auth_cubit.dart';
import 'package:alharamin_app/features/auth/presentation/widgets/user_form_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserLoginBody extends StatelessWidget {
  const UserLoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          flutterToast('Login successful');
          context.go(AppRoutes.userHome, extra: state.user);
        } else if (state is AuthFailure) {
          flutterToast(state.errMessage);
        }
      },
      builder: (context, state) {
        final bool isLoading = state is AuthLoading;
        final bool isAutoLoginChecking =
            state is AuthInitial && state.isCheckingAutoLogin;

        return Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (!isAutoLoginChecking) ...[
                        RegisterationHeaderSection(
                          headerTitle: 'Sign In',
                          headerSubTitle:
                              'We\'re excited to have you back, can\'t wait to see what you\'ve been up to since you last logged in.',
                        ),
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
                          onPressed: () {
                            context.push(AppRoutes.register);
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading || isAutoLoginChecking) const LoadingOverlay(),
          ],
        );
      },
    );
  }
}
