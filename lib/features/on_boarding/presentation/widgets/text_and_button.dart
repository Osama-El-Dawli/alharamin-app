import 'package:alharamin_app/core/routes/app_routes.dart';
import 'package:alharamin_app/core/theme/styles.dart';
import 'package:alharamin_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TextAndButton extends StatelessWidget {
  const TextAndButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              'Manage and schedule all of your medical appointments easily with Docdoc to get a new experience.',
              textAlign: TextAlign.center,
              style: Styles.font12W400Grey,
            ),
          ),
          SizedBox(height: 42.h),
          CustomButton(
            text: 'Get Started',
            onPressed: () => context.push(AppRoutes.login),
          ),
          SizedBox(height: 42.h),
        ],
      ),
    );
  }
}
