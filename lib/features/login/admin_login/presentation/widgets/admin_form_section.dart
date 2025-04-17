import 'package:alharamin_app/core/routes/app_routes.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/core/widgets/custom_button.dart';
import 'package:alharamin_app/core/widgets/custom_text_field.dart';
import 'package:alharamin_app/features/login/admin_login/logic/cubits/admin_login_cubit/admin_login_cubit.dart';
import 'package:alharamin_app/core/widgets/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AdminFormSection extends StatefulWidget {
  const AdminFormSection({super.key});

  @override
  State<AdminFormSection> createState() => _AdminFormSectionState();
}

class _AdminFormSectionState extends State<AdminFormSection> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passcodeController = TextEditingController();
  bool isObscureText = true;

  @override
  void dispose() {
    passcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminLoginCubit, AdminLoginState>(
      listener: (context, state) {
        if (state is AdminLoginSuccess) {
          context.go(AppRoutes.adminHome);
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Passcode',
                style: Styles.font24W600Primary.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 14.h),
              CustomTextField(
                hintText: 'Passcode',
                obscureText: isObscureText,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isObscureText = !isObscureText;
                    });
                  },
                  icon: Icon(
                    isObscureText ? Icons.visibility_off : Icons.visibility_off,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter passcode';
                  }
                  return null;
                },
                errorText: state.errMessage,
                onChanged: (_) => context.read<AdminLoginCubit>().clearError(),
                controller: passcodeController,
              ),
              SizedBox(height: 30.h),
              CustomButton(
                text: 'Login',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    context.read<AdminLoginCubit>().submitPasscode(
                      passcodeController.text,
                    );
                  }
                },
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: TermsAndConditions(),
              ),
            ],
          ),
        );
      },
    );
  }
}
