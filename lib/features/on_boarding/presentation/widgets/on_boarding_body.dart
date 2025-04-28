import 'package:alharamin_app/core/routes/app_routes.dart';
import 'package:alharamin_app/features/on_boarding/presentation/widgets/doctor_image_and_text.dart';
import 'package:alharamin_app/features/on_boarding/presentation/widgets/header_logo.dart';
import 'package:alharamin_app/features/on_boarding/presentation/widgets/text_and_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeaderLogo(),
          SizedBox(height: 30.h),
          DoctorImageAndText(),
          SizedBox(height: 25.h),
          TextAndButton(
            onPressed: () {
              context.go(AppRoutes.authGate);
            },
          ),
        ],
      ),
    );
  }
}
