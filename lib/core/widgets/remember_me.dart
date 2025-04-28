import 'package:alharamin_app/core/theme/app_colors.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RememberMe extends StatelessWidget {
  const RememberMe({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        bool rememberMeState = false;
        if (state is RememberMeState) {
          rememberMeState = state.rememberMe;
        }
        return InkWell(
          onTap: () {
            context.read<AuthCubit>().toggleRememberMe();
          },
          child: Row(
            children: [
              Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                hoverColor: AppColors.primary,
                activeColor: AppColors.primary,
                value: rememberMeState,
                onChanged: (newValue) {
                  context.read<AuthCubit>().toggleRememberMe();
                },
              ),
              Text('Remember me', style: Styles.font14W400Grey),
            ],
          ),
        );
      },
    );
  }
}
