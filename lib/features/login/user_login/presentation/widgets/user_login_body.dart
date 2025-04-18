import 'package:alharamin_app/core/functions/snack_bar.dart';
import 'package:alharamin_app/core/routes/app_routes.dart';
import 'package:alharamin_app/core/widgets/have_account.dart';
import 'package:alharamin_app/core/widgets/loading_overlay.dart';
import 'package:alharamin_app/core/widgets/registeration_header_section.dart';
import 'package:alharamin_app/core/widgets/terms_and_conditions.dart';
import 'package:alharamin_app/features/login/user_login/logic/cubit/user_login_cubit/user_login_cubit.dart';
import 'package:alharamin_app/features/login/user_login/presentation/widgets/user_form_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UserLoginBody extends StatelessWidget {
  const UserLoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLoginCubit, UserLoginState>(
      listener: (context, state) {
        if (state is UserLoginSuccess) {
          snackBar(context, content: 'Login successful');
          context.go(AppRoutes.userHome);
        } else if (state is UserLoginFailure) {
          snackBar(context, content: state.errMessage);
        }
      },
      builder: (context, state) {
        final bool isLoading = state is UserLoginLoading;
        final bool isAutoLoginChecking =
            state is UserLoginInitial && (state).isCheckingAutoLogin;

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
